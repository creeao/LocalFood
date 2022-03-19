//
//  MenuViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import UIKit

final class MenuViewController: UIViewController, MenuRoutingLogicDelegate {

    // MARK: Properties
    var interactor: MenuBusinessLogic?
    var router: MenuRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var tableView = UITableView()
    private var items = [MenuItem]()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: MenuDisplayLogic
extension MenuViewController: MenuDisplayLogic {
    func displayContent(viewModel: Menu.Content.ViewModel) {}
}

// MARK: Actions
private extension MenuViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
    
    func openOrders() {
        router?.routeToOrders()
    }
    
    func editProfile() {
        router?.routeToEditProfile()
    }
    
    func logout() {
        router?.routeToLogout()
    }
}

// MARK: Private
private extension MenuViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupTableView()
        setupBackButton()
        setupItems()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")
        titleLabel.text = "Menu"

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
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.backgroundColor = UIColor(named: "lightGray")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupItems() {
        let orders = MenuItem(id: 1, name: "Zamówienia")
        let editProfile = MenuItem(id: 2, name: "Edytuj profil")
        let logout = MenuItem(id: 1, name: "Wyloguj")
        items = [orders, editProfile, logout]
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openOrders()
        case 1:
            editProfile()
        case 2:
            logout()
        default:
            return
        }
    }
}

// MARK: UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell
        cell?.setup(with: items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
