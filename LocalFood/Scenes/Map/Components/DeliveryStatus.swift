//
//  DeliveryStatus.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 05/03/2022.
//

import UIKit

protocol DeliveryStatusDelegate: AnyObject {
    func showOrderInfornations()
}

final class DeliveryStatus: UIView {
    private var contentView = UIView()
    private var statusLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var costLabel = UILabel()
    private var timeLabel = UILabel()
    private var orderInfornationsButton = UIButton()
    weak var delegate: DeliveryStatusDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(status: OrderStatus, placeName: String, cost: String, time: String) {
        statusLabel.text = status.text
        descriptionLabel.text = "Z: " + placeName
        costLabel.text = cost
        timeLabel.text = time
    }
}

// MARK: Private
private extension DeliveryStatus {
    func setupView() {
        backgroundColor = UIColor(named: "white")
        layer.cornerRadius = 15
        layer.shadowColor = UIColor(named: "black")?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 45
        alpha = 0
        
        setupStatusLabel()
        setupDescriptionLabel()
        setupCostLabel()
        setupTimeLabel()
        setupOrderInformationsButton()
    }
    
    func setupStatusLabel() {
        addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .bold)
        statusLabel.textColor = UIColor(named: "black")
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        descriptionLabel.textColor = UIColor(named: "darkGray")
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupCostLabel() {
        addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        costLabel.textColor = UIColor(named: "darkGray")
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            costLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    
    func setupTimeLabel() {
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        timeLabel.textColor = UIColor(named: "darkGray")
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupOrderInformationsButton() {
        addSubview(orderInfornationsButton)
        orderInfornationsButton.translatesAutoresizingMaskIntoConstraints = false
        orderInfornationsButton.setupPrimaryView(with: "Informacje o zamówieniu")
        orderInfornationsButton.addTarget(self, action: #selector(orderInfornationsButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            orderInfornationsButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            orderInfornationsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            orderInfornationsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            orderInfornationsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            orderInfornationsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func orderInfornationsButtonTapped() {
        delegate?.showOrderInfornations()
    }
}
