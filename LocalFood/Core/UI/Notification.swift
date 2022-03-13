//
//  Notification.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 05/03/2022.
//

import UIKit

enum NotificationColor {
    case green
    case red
}

final class Notification: UIView {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(text: String, _ color: NotificationColor) {
        label.text = text
        if color == .green {
            setupGreen()
        } else {
            setupRed()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveLinear, animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
    
    private func setupView() {
        alpha = 0
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
        
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = UIColor(named: "white")
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupGreen() {
        backgroundColor = UIColor(named: "success")
        layer.shadowColor = UIColor(named: "success")?.cgColor
    }
    
    private func setupRed() {
        backgroundColor = UIColor(named: "failure")
        layer.shadowColor = UIColor(named: "failure")?.cgColor
    }
}
