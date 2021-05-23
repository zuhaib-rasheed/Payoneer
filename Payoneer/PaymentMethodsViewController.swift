//
//  ViewController.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 11.05.21.
//

import UIKit
import Combine

class PaymentMethodsViewController: UITableViewController {
    private var viewModel: PaymentListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PaymentListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerCells()
        viewModel.fetchProviderDetails()
    }
    
    private func bindViewProperties() {
        viewModel.$uiState
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                guard !message.isEmpty else { return }
                self?.viewModel.displayErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9568627451, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "PaymentProviderTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PaymentProviderTableViewCell.identifier)
    }
}

extension PaymentMethodsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.paymentNetworksCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentProviderTableViewCell.identifier) as? PaymentProviderTableViewCell
        cell?.setupCell(name: viewModel.networks[indexPath.row].providerName, imageURL: viewModel.networks[indexPath.row].providerImage)
        return cell ?? UITableViewCell()
    }
}
