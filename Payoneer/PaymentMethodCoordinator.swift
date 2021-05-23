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
        let viewModel = PaymentListViewModel(delegate: self)
        let paymentMethodViewController = PaymentMethodsViewController(viewModel: viewModel)
        paymentMethodViewController.title = "Payment Methods"
        presenter.pushViewController(paymentMethodViewController, animated: true)
    
        self.paymentMethodViewController = paymentMethodViewController
    }
}

extension PaymentMethodCoordinator: PaymentListViewModelDelegate {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        presenter.present(alert, animated: true)
    }
}
