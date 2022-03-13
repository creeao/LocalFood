//
//  UITextField.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

extension UITextField {
    func setupView() {
        layer.borderColor = UIColor(named: "mediumGray")?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = Constants.cornerRadius
        textAlignment = .center
        textColor = UIColor(named: "black")
        attributedPlaceholder = NSAttributedString(string: "My Placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "mediumGray")])
    }
}
