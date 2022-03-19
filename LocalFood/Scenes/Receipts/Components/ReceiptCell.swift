//
//  ReceiptCell.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

class ReceiptCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var receipt = ReceiptItem(placeName: "", cost: "", date: "", id: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with receipt: ReceiptItem) {
        self.receipt = receipt
        titleLabel.text = receipt.placeName
        descriptionLabel.text = receipt.date + " | " + receipt.cost
    }
    
    func getId() -> Date {
        return receipt.id ?? Date()
    }
}

// MARK: Private
private extension ReceiptCell {
    func setupView() {
        [titleLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setupTitleLabel()
        setupDescriptionLabel()
        selectionStyle = .none
        backgroundColor = UIColor(named: "transparent")
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        titleLabel.textColor = UIColor(named: "darkGray")
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")
        descriptionLabel.alpha = 0.5
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}

