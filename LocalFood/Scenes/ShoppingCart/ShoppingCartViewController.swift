//
//  ShoppingCartViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

final class ShoppingCartViewController: UIViewController, ShoppingCartRoutingLogicDelegate {

    // MARK: Properties
    var interactor: ShoppingCartBusinessLogic?
    var router: ShoppingCartRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var tableView = UITableView()
    private var orderButton = UIButton()
    private var products = [Product]()
    private var notification = Notification()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: Private
private extension ShoppingCartViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupTableView()
        setupOrderButton()
        setupNavigationBar()
        setupNotification()
    }
    
    func setupNavigationBar() {
        setupBackButton()
    }
    
    func setupNotification() {
        view.addSubview(notification)
        notification.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notification.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            notification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            notification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            notification.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Koszyk"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")

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
        tableView.register(ShopingCartProductCell.self, forCellReuseIdentifier: "ShopingCartProductCell")
        tableView.backgroundColor = UIColor(named: "lightGray")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupOrderButton() {
        view.addSubview(orderButton)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            orderButton.heightAnchor.constraint(equalToConstant: 50),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    func setupDisableOrderButton() {
        if products.isEmpty {
            orderButton.setupDisablePrimaryView()
            orderButton.setTitle("Brak dodanych produktów", for: .normal)
            orderButton.isEnabled = false
        } else {
            orderButton.setupPrimaryView(with: "Zamów")
            orderButton.isEnabled = true
        }
    }
}

// MARK: Actions
private extension ShoppingCartViewController {
    @objc func orderButtonTapped() {
        guard let place = Orders.shared.selectedPlace else { return }
        Orders.shared.makeOrder(products: products, place: place)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func makeOrder() {
        interactor?.makeOrder(request: .init())
    }
    
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
}

// MARK: ShoppingCartDisplayLogic
extension ShoppingCartViewController: ShoppingCartDisplayLogic {
    func displayContent(viewModel: ShoppingCart.Content.ViewModel) {
        DispatchQueue.main.async {
            viewModel.products.forEach {
                self.products.append($0)
            }
            self.setupDisableOrderButton()
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate
extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ShopingCartProductCell else { return }
        Basket.shared.removeProduct(with: selectedCell.getName())
        products.remove(at: indexPath.row)
        tableView.reloadData()
        setupDisableOrderButton()
        notification.display(.deleted)
    }
}

// MARK: UITableViewDataSource
extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopingCartProductCell", for: indexPath) as? ShopingCartProductCell
        cell?.setup(with: products[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
