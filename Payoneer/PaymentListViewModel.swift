//
//  PaymentMethodsViewModel.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 12.05.21.
//

import Combine
import Foundation

class PaymentListViewModel: ObservableObject {
    @Published var networks = [PaymentNetworkViewModel]()
    @Published var uiState: UIState<ListResult> = .created

    private var cancellables: Set<AnyCancellable> = []
    
    func fetchProviderDetails() {
        PayoneerApi.paymentMethodsList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] response in
                self?.uiState = .ready(response)
                self?.networks = response.networks.applicable.map {
                    PaymentNetworkViewModel(paymentNetwork: $0)
                }
            })
            .store(in: &cancellables)
    }
    
    var paymentNetworksCount: Int {
        networks.count
    }
}