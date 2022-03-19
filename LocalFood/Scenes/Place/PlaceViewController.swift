//
//  PlaceViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import UIKit

final class PlaceViewController: UIViewController, PlaceRoutingLogicDelegate {

    // MARK: Properties
    var interactor: PlaceBusinessLogic?
    var router: PlaceRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var tableView = UITableView()
    private var popup = SelectedProductPopup()
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
private extension PlaceViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupDescriptionLabel()
        setupTableView()
        setupPopup()
        setupNavigationBar()
        setupNotification()
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ProductCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(named: "lightGray")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupPopup() {
        view.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.deleagte = self
        popup.alpha = 0
        
        NSLayoutConstraint.activate([
            popup.heightAnchor.constraint(equalToConstant: 250),
            popup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            popup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            popup.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupNavigationBar() {
        setupBackButton()
        let shoppingCartIcon = UIImage(systemName: "cart.fill")
        let shoppingCartItem = UIBarButtonItem(image: shoppingCartIcon, style: .done, target: self, action: #selector(routeToShoppingCart))
        
        navigationItem.rightBarButtonItem = shoppingCartItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "darkGray")
    }
    
    @objc func routeToShoppingCart() {
        router?.routeToShoppingCart()
    }
}

// MARK: Actions
private extension PlaceViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
}

// MARK: PlaceDisplayLogic
extension PlaceViewController: PlaceDisplayLogic {
    func displayContent(viewModel: Place.Content.ViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.place.name
            self.descriptionLabel.text = viewModel.place.description
            viewModel.place.products.forEach {
                self.products.append($0)
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: SelectedProductPopupDelegate
extension PlaceViewController: SelectedProductPopupDelegate {
    func addProduct() {
        notification.display(text: "Dodano do koszyka", .green)
    }
}

// MARK: UITableViewDelegate
extension PlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ProductCell else { return }
        popup.setup(with: selectedCell.getProduct())
        UIView.animate(withDuration: 0.2) {
            self.popup.alpha = 1
        }
    }
}

// MARK: UITableViewDataSource
extension PlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductCell
        cell?.setup(with: products[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
