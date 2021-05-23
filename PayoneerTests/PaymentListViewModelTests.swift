//
//  PaymentListViewModelTests.swift
//  PayoneerTests
//
//  Created by Zuhaib Rasheed on 22.05.21.
//

@testable import Payoneer
import XCTest
import Combine

class PaymentListViewModelTests: XCTestCase {
    var viewModel: PaymentListViewModel!
    var cancellables: Set<AnyCancellable>!
    var mockDelegate: MockPaymentListViewModelDelegate!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockDelegate = MockPaymentListViewModelDelegate()
        viewModel = PaymentListViewModel(delegate: mockDelegate)
    }

    override func tearDown() {
        super.tearDown()
        cancellables = nil
        mockDelegate = nil
        viewModel = nil
    }
    
    func testFetchProviderDetails() {
        var networks = [PaymentNetworkViewModel]()
        let fetchExpectation = XCTestExpectation(description: "expectation for fetch data")
        
        viewModel.$uiState
            .sink { state in
                guard case let .ready(response) = state else {
                    return
                }
                networks = response.networks.applicable.map {
                    PaymentNetworkViewModel(paymentNetwork: $0)
                }
                fetchExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchProviderDetails()
        wait(for: [fetchExpectation], timeout: 5)
        
        XCTAssertFalse(networks.isEmpty)
    }
    
    func testAlertMessage() {
        viewModel.displayErrorAlert(message: "Internal error happened with status code: 404")
        XCTAssertEqual(mockDelegate.message, "Internal error happened with status code: 404")
    }
}

class MockPaymentListViewModelDelegate: PaymentListViewModelDelegate {
    var message = ""
    
    func showErrorAlert(message: String) {
        self.message = message
    }
}
