//
//  UIButton.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 20/02/2022.
//

import UIKit

extension UIButton {
    func setupPrimaryView(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(UIColor(named: "white"), for: .normal)
        setTitleColor(UIColor(named: "lightGray"), for: .highlighted)
        backgroundColor = UIColor(named: "primary")
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowColor = UIColor(named: "primary")?.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
    
    func setupDisablePrimaryView() {
        setTitleColor(UIColor(named: "white"), for: .normal)
        backgroundColor = UIColor(named: "darkGray")
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowColor = UIColor(named: "darkGray")?.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
    
    func setupSecondaryView(for type: SecondaryButtonType) {
        setTitle(type == .plus ? "+" : "-", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 36.0, weight: .semibold)
        setTitleColor(UIColor(named: "primary"), for: .normal)
        setTitleColor(UIColor(named: "darkGray"), for: .highlighted)
    }
}

enum SecondaryButtonType {
    case minus
    case plus
}
