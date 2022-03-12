//
//  RegistrationViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import UIKit

final class RegistrationViewController: UIViewController, RegistrationRoutingLogicDelegate {

    // MARK: Properties
    var interactor: RegistrationBusinessLogic?
    var router: RegistrationRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var stackView = UIStackView()
    private var nameTextField = UITextField()
    private var surnameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var registerButton = UIButton()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: Private
private extension RegistrationViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupStackView()
        setupFields()
        setupRegisterButton()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        setupBackButton()
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
    
    func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupFields() {
        [nameTextField, surnameTextField, emailTextField, passwordTextField].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nameTextField.placeholder = "Imię"
        surnameTextField.placeholder = "Nazwisko"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Hasło"
    }

    func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    func setupDisableRegisterButton() {
        if fieldsIsNotEmpty() {
            registerButton.setupDisablePrimaryView()
            registerButton.setTitle("Zarejestruj", for: .normal)
            registerButton.isEnabled = false
        } else {
            registerButton.setupPrimaryView(with: "Zarejestruj")
            registerButton.isEnabled = true
        }
    }
    
    func fieldsIsNotEmpty() -> Bool {
        return ![nameTextField, surnameTextField, emailTextField, passwordTextField].contains(where: { $0.text == "" })
    }
}

// MARK: Actions
private extension RegistrationViewController {
    @objc func registerButtonTapped() {
        // TODO: Add DB
        navigationController?.popToRootViewController(animated: true)
    }
    
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
}

// MARK: RegistrationDisplayLogic
extension RegistrationViewController: RegistrationDisplayLogic {
    func displayContent(viewModel: Registration.Content.ViewModel) {

    }
}
