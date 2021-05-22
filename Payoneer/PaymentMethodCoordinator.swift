//
//  ApplicationCoordinator.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 22.05.21.
//

import UIKit

class PaymentMethodCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var paymentMethodViewController: PaymentMethodsViewController?
    
    init(presenter: UINavigationController) {
      self.presenter = presenter
    }
    
    func start() {
        let viewModel = PaymentListViewModel()
        let paymentMethodViewController = PaymentMethodsViewController(viewModel: viewModel)
        paymentMethodViewController.title = "Payment Methods"
        presenter.pushViewController(paymentMethodViewController, animated: true)
    
        self.paymentMethodViewController = paymentMethodViewController
    }
}
