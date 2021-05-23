import Foundation
import Combine

enum ServiceErrors: Error {
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}

struct PayoneerClient {
    let session = URLSession.shared
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, ServiceErrors> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    switch (response as! HTTPURLResponse).statusCode {
                    case (400...499):
                        throw ServiceErrors.internalError((response as! HTTPURLResponse).statusCode)
                    case (500...599):
                        throw ServiceErrors.serverError((response as! HTTPURLResponse).statusCode)
                    default:
                        throw ServiceErrors.serverError((response as! HTTPURLResponse).statusCode)
                    }
                }
                let value = try decoder.decode(T.self, from: data)
                return Response(value: value, response: response)
            }
            .mapError { $0 as! ServiceErrors }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum PayoneerApi {
    static let client = PayoneerClient()
    static let url = URL(string: "https://raw.githubusercontent.com/optile/checkout-android/develop/shared-test/lists/listresult.json")!
}

extension PayoneerApi {
    static func paymentMethodsList() -> AnyPublisher<ListResult, ServiceErrors> {
        return run(URLRequest(url: url))
    }

    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, ServiceErrors> {
        return client.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

