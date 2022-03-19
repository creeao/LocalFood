//
//  LoginViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

final class LoginViewController: UIViewController, LoginRoutingLogicDelegate {

    // MARK: Properties
    var interactor: LoginBusinessLogic?
    var router: LoginRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var contentView = UIView()
    private var stackView = UIStackView()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var notification = Notification()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: Private
private extension LoginViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupContentView()
        setupStackView()
        setupFields()
        setupLoginButton()
        setupNavigationBar()
        setupHiddenKeyboard()
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
        titleLabel.text = "Logowanie"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "lightGray")
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func setupFields() {
        [emailTextField, passwordTextField].forEach {
            setupField($0)
        }
    
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Hasło"
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupField(_ textField: UITextField) {
        stackView.addArrangedSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setupView()
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupLoginButton() {
        contentView.addSubview(loginButton)
        loginButton.setupPrimaryView(with: "Zaloguj")
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48)
        ])
    }
    
    func fieldsIsNotEmpty() -> Bool {
        return ![emailTextField, passwordTextField].contains(where: { $0.text == "" })
    }
}

// MARK: Actions
private extension LoginViewController {
    @objc func loginButtonTapped() {        
        if fieldsIsNotEmpty() {
            interactor?.login(request: .init(
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""))
        } else {
            notification.display(text: "Uzupełnij wszystkie pola", .red)
        }
    }
}

// MARK: LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func displayLoginResult(viewModel: Login.Login.ViewModel) {
        if viewModel.isLoginSuccessfull {
            router?.routeToMap()
        } else {
            notification.display(text: "Błędny login lub hasło", .red)
        }
    }
}
