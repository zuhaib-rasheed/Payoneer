//
//  PaymentMethodsViewModel.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 12.05.21.
//

import Combine
import Foundation

class PaymentNetworkViewModel: ObservableObject {
    private var paymentNetwork: ApplicableNetwork
    
    init(paymentNetwork: ApplicableNetwork) {
        self.paymentNetwork = paymentNetwork
    }
    
    var providerName: String {
        paymentNetwork.label
    }
    
    var providerImage: URL? {
        paymentNetwork.links?["logo"]
    }
}
