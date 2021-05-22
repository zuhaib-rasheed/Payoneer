//
//  ApplicationCoordinator.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 22.05.21.
//

import UIKit

protocol Coordinator {
    func start()
}

class ApplicationCoordinator: Coordinator {
  let window: UIWindow
  let rootViewController: UINavigationController
  let paymentMethodCoordinator: PaymentMethodCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()
    paymentMethodCoordinator = PaymentMethodCoordinator(presenter: rootViewController)
  }
  
  func start() {
    window.rootViewController = rootViewController
    paymentMethodCoordinator.start()
    window.makeKeyAndVisible()
  }
}
