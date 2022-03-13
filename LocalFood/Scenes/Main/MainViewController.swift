//
//  MainViewController.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

final class MainViewController: UIViewController, MainRoutingLogicDelegate {

    // MARK: Properties
    var interactor: MainBusinessLogic?
    var router: MainRouting?

    // MARK: Subviews
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var contentView = UIView()
    private var logoImageView = UIImageView()
    private var loginButton = UIButton()
    private var separatorLabel = UILabel()
    private var registerButton = UIButton()
    private var notification = Notification()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: Private
private extension MainViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "white")
        setupTitleLabel()
        setupDescriptionLabel()
        setupContentView()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Witaj w Local Food!"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        titleLabel.textColor = UIColor(named: "black")

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "Szybko, tanio, świeżo.."
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "lightGray")
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupLoginButton()
        setupSeparatorLabel()
        setupRegisterButton()
        setupLogoImageView()
    }

    func setupLoginButton() {
        contentView.addSubview(loginButton)
        loginButton.setupPrimaryView(with: "Logowanie")
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func setupSeparatorLabel() {
        contentView.addSubview(separatorLabel)
        separatorLabel.text = "lub"
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        separatorLabel.textColor = UIColor(named: "darkGray")
        separatorLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            separatorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            separatorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func setupRegisterButton() {
        contentView.addSubview(registerButton)
        registerButton.setupPrimaryView(with: "Rejestracja")
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor, constant: 16),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupLogoImageView() {
        contentView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logoLightGray")
        logoImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 36),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: Actions
private extension MainViewController {
    @objc func loginButtonTapped() {
        router?.routeToLogin()
    }
    
    @objc func registerButtonTapped() {
        router?.routeToRegister()
    }
}

// MARK: MainDisplayLogic
extension MainViewController: MainDisplayLogic {}
