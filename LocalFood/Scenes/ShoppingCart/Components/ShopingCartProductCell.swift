//
//  ShopingCartProductCell.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 20/02/2022.
//

import UIKit

class ShopingCartProductCell: UITableViewCell {
    private let label = UILabel()
    private let button = UIButton()
    private var product = Product(name: "", price: 0.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with product: Product) {
        self.product = product
        label.text = product.name
    }
    
    func getName() -> String {
        product.name
    }
    
    func getProduct() -> Product {
        product
    }
    
    private func setupView() {
        [label, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setupLabel()
        setupButton()
        selectionStyle = .none
        backgroundColor = UIColor(named: "transparent")
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = UIColor(named: "darkGray")
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupButton() {
        button.setupSecondaryView(for: .minus)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}
