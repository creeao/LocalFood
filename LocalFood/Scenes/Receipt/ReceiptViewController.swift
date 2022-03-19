//
//  ReceiptViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit
import MapKit

final class ReceiptViewController: UIViewController, ReceiptRoutingLogicDelegate {

    // MARK: Properties
    var interactor: ReceiptBusinessLogic?
    var router: ReceiptRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var tableView = UITableView()
    private var products = [Product]()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: Private
private extension ReceiptViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupBackButton()
        setupTitleLabel()
        setupDescriptionLabel()
        setupTableView()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.text = "Paragon"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")
        descriptionLabel.numberOfLines = 2

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ReceiptProductCell.self, forCellReuseIdentifier: "ReceiptProductCell")
        tableView.backgroundColor = UIColor(named: "lightGray")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Actions
private extension ReceiptViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
}

// MARK: ReceiptDisplayLogic
extension ReceiptViewController: ReceiptDisplayLogic {
    func displayContent(viewModel: Receipt.Content.ViewModel) {
        DispatchQueue.main.async {
            viewModel.products.forEach {
                self.products.append($0)
            }

            let cost = String(format: "%.2f", viewModel.orderValue)
            self.descriptionLabel.text = "Z: " + viewModel.placeName + "\nWartość: \(cost) PLN"
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate
extension ReceiptViewController: UITableViewDelegate {}

// MARK: UITableViewDataSource
extension ReceiptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptProductCell", for: indexPath) as? ReceiptProductCell
        cell?.setup(with: products[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
