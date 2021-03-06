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
    private var contentView = UIView()
    private var stackView = UIStackView()
    private var nameTextField = UITextField()
    private var surnameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var registerButton = UIButton()
    private var notification = Notification()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: Private
private extension RegistrationViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupContentView()
        setupStackView()
        setupFields()
        setupRegisterButton()
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
        titleLabel.text = "Rejestracja"
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
        [nameTextField, surnameTextField, emailTextField, passwordTextField].forEach {
            setupField($0)
        }
        
        nameTextField.placeholder = "Imi??"
        surnameTextField.placeholder = "Nazwisko"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Has??o"
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

    func setupRegisterButton() {
        contentView.addSubview(registerButton)
        registerButton.setupPrimaryView(with: "Zarejestruj")
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48)
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
        if fieldsIsNotEmpty() {
            let data = Account(
                name: nameTextField.text ?? "",
                surname: surnameTextField.text ?? "",
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? "")
            interactor?.register(request: .init(data: data))
        } else {
            notification.display(text: "Uzupe??nij wszystkie pola", .red)
        }
    }
}

// MARK: RegistrationDisplayLogic
extension RegistrationViewController: RegistrationDisplayLogic {
    func displayRegisterResult(viewModel: Registration.Register.ViewModel) {
        if viewModel.isRegisterSuccessfull {
            navigationController?.popToRootViewController(animated: true)
        } else {
            notification.display(text: "Konto ju?? istnieje", .red)
        }
    }
}
