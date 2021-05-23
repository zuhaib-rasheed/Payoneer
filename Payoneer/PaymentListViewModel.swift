//
//  PaymentMethodsViewModel.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 12.05.21.
//

import Combine
import Foundation

protocol PaymentListViewModelDelegate: AnyObject {
    func showErrorAlert(message: String)
}

class PaymentListViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var networks = [PaymentNetworkViewModel]()
    @Published var uiState: UIState<ListResult> = .created

    private weak var delegate: PaymentListViewModelDelegate?
    private var cancellables: Set<AnyCancellable> = []
    
    init(delegate: PaymentListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchProviderDetails() {
        PayoneerApi.paymentMethodsList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    switch error {
                    case let .internalError(statusCode):
                        self.errorMessage = "Internal error happened with status code: \(statusCode)"
                    case let .serverError(statusCode):
                        self.errorMessage = "Server error happened with status code: \(statusCode)"
                    }
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
    
    func displayErrorAlert(message: String) {
        delegate?.showErrorAlert(message: message)
    }
}
