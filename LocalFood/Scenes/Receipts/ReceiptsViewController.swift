//
//  ReceiptsViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

final class ReceiptsViewController: UIViewController, ReceiptsRoutingLogicDelegate {

    // MARK: Properties
    var interactor: ReceiptsBusinessLogic?
    var router: ReceiptsRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var tableView = UITableView()
    private var items = [ReceiptItem]()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: ReceiptsDisplayLogic
extension ReceiptsViewController: ReceiptsDisplayLogic {
    func displayContent(viewModel: Receipts.Content.ViewModel) {
        items = viewModel.orders
        tableView.reloadData()
    }
}

// MARK: Actions
private extension ReceiptsViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
}

// MARK: Private
private extension ReceiptsViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupTableView()
        setupBackButton()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.text = "Receipts"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ReceiptCell.self, forCellReuseIdentifier: "ReceiptCell")
        tableView.backgroundColor = UIColor(named: "lightGray")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate
extension ReceiptsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ReceiptCell else { return }
        router?.routeToOrderInformation(id: selectedCell.getId())
    }
}

// MARK: UITableViewDataSource
extension ReceiptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptCell", for: indexPath) as? ReceiptCell
        cell?.setup(with: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
