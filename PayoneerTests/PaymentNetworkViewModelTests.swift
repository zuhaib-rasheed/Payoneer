//
//  PaymentMethodsViewModelTests.swift
//  PayoneerTests
//
//  Created by Zuhaib Rasheed on 12.05.21.
//

@testable import Payoneer
import XCTest
import Combine

class PaymentNetworkViewModelTests: XCTestCase {
    var viewModel: PaymentNetworkViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PaymentNetworkViewModel(paymentNetwork: ApplicableNetwork.example)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testProviderName() {
        XCTAssertEqual(viewModel.providerName, "American Express")
    }
    
    func testProviderImage() {
        XCTAssertEqual(viewModel.providerImage, URL(string: "https://resources.integration.oscato.com/resource/network/MOBILETEAM/en_US/AMEX/logo3x.png"))
    }
}
