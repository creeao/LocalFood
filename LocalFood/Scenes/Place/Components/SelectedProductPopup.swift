//
//  SelectedProductPopup.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 09/01/2022.
//

import UIKit

protocol SelectedProductPopupDelegate: AnyObject {
    func addProduct()
}

class SelectedProductPopup: UIView {
    private var exitButton = UIButton()
    private var productName = UILabel()
    private var countContainer = UIView()
    
    private var decreaseButton = UIButton()
    private var countLabel = UILabel()
    private var increaseButton = UIButton()
    private var addButton = UIButton()
    
    private var product = Product(name: "", price: 0.0)
    
    var count: Int = 1
    
    weak var deleagte: SelectedProductPopupDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with newProduct: Product) {
        product = newProduct
        productName.text = product.name
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "white")
        layer.cornerRadius = 15
        alpha = 0
        layer.shadowColor = UIColor(named: "black")?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 45
        
        setupExitButton()
        setupProductName()
        setupCountContainerView()
        setupAddButton()
    }
    
    private func setupExitButton() {
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "xmark")?.withTintColor(UIColor(named: "black") ?? .black)
        exitButton.setImage(image, for: .normal)
        exitButton.tintColor = UIColor(named: "black")
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        exitButton.setTitleColor(UIColor(named: "black"), for: .normal)
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProductName() {
        addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        productName.textColor = UIColor(named: "black")
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupCountContainerView() {
        addSubview(countContainer)
        countContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countContainer.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 8),
            countContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            countContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        setupCountLabel()
        setupDecreaseButton()
        setupIncreaseButton()
    }

    private func setupDecreaseButton() {
        countContainer.addSubview(decreaseButton)
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        decreaseButton.addTarget(self, action: #selector(decreaseCount), for: .touchUpInside)
        decreaseButton.setupSecondaryView(for: .minus)
        
        NSLayoutConstraint.activate([
            decreaseButton.topAnchor.constraint(equalTo: countContainer.topAnchor, constant: 8),
            decreaseButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -32),
            decreaseButton.bottomAnchor.constraint(equalTo: countContainer.bottomAnchor, constant: -8),
            decreaseButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    private func setupCountLabel() {
        countContainer.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = "\(count)"
        countLabel.textColor = UIColor(named: "darkGray")
        countLabel.font = UIFont.systemFont(ofSize: 50.0, weight: .semibold)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: countContainer.topAnchor),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: countContainer.bottomAnchor)
        ])
    }

    private func setupIncreaseButton() {
        countContainer.addSubview(increaseButton)
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
        increaseButton.setupSecondaryView(for: .plus)
        
        NSLayoutConstraint.activate([
            increaseButton.topAnchor.constraint(equalTo: countContainer.topAnchor, constant: 8),
            increaseButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 32),
            increaseButton.bottomAnchor.constraint(equalTo: countContainer.bottomAnchor, constant: -8),
            increaseButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setupAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setupPrimaryView(with: "Dodaj do koszyka")
        addButton.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: countContainer.bottomAnchor, constant: 36),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func decreaseCount() {
        count > 0 ? count -= 1 : nil
        countLabel.text = "\(count)"
    }
    
    @objc private func increaseCount() {
        count += 1
        countLabel.text = "\(count)"
    }
    
    @objc private func addProduct() {
        for _ in 1...count {
            Basket.shared.addProduct(product)
        }
            
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.count = 1
            self.countLabel.text = "\(self.count)"
        }
        
        deleagte?.addProduct()
    }
    
    @objc private func exitAction() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.count = 1
            self.countLabel.text = "\(self.count)"
        }
    }
}
