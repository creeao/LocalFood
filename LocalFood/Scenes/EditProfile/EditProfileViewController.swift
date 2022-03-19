//
//  EditProfileViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

final class EditProfileViewController: UIViewController, EditProfileRoutingLogicDelegate {

    // MARK: Properties
    var interactor: EditProfileBusinessLogic?
    var router: EditProfileRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var contentView = UIView()
    private var stackView = UIStackView()
    private var nameTextField = UITextField()
    private var surnameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var editButton = UIButton()
    private var notification = Notification()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareContent()
    }
}

// MARK: Private
private extension EditProfileViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupContentView()
        setupStackView()
        setupFields()
        setupEditButton()
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
        titleLabel.text = "Edytuj profil"
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
        
        nameTextField.placeholder = "Imię"
        surnameTextField.placeholder = "Nazwisko"
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

    func setupEditButton() {
        contentView.addSubview(editButton)
        editButton.setupPrimaryView(with: "Zaaktualizuj dane")
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            editButton.heightAnchor.constraint(equalToConstant: 50),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48)
        ])
    }
    
    func fieldsIsNotEmpty() -> Bool {
        return ![nameTextField, surnameTextField, emailTextField, passwordTextField].contains(where: { $0.text == "" })
    }
}

// MARK: Actions
private extension EditProfileViewController {
    func prepareContent() {
        interactor?.prepareContent(request: .init())
    }
    
    @objc func editButtonTapped() {
        if fieldsIsNotEmpty() {
            let data = Account(
                name: nameTextField.text ?? "",
                surname: surnameTextField.text ?? "",
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? "")
            interactor?.edit(request: .init(data: data))
        } else {
            notification.display(text: "Pola nie mogą być puste", .red)
        }
    }
}

// MARK: EditProfileDisplayLogic
extension EditProfileViewController: EditProfileDisplayLogic {
    func displayContent(viewModel: EditProfile.Content.ViewModel) {
        nameTextField.text = viewModel.data.name
        surnameTextField.text = viewModel.data.surname
        emailTextField.text = viewModel.data.email
        passwordTextField.text = viewModel.data.password
    }
    
    func displayEditResult(viewModel: EditProfile.Edit.ViewModel) {
        if viewModel.isEditSuccessfull {
            notification.display(text: "Dane zostały zaaktualiowane", .green)
        } else {
            notification.display(text: "Dane nie zostały zaaktualizowane", .red)
        }
    }
}
