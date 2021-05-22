import Foundation
import Combine

struct PayoneerClient {
    let session = URLSession.shared
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum PayoneerApi {
    static let client = PayoneerClient()
    static let url = URL(string: "https://raw.githubusercontent.com/optile/checkout-android/develop/shared-test/lists/listresult.json")!
}

extension PayoneerApi {
    static func paymentMethodsList() -> AnyPublisher<ListResult, Error> {
        return run(URLRequest(url: url))
    }

    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return client.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

