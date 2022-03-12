//
//  NavigationBar.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 20/02/2022.
//

import UIKit

extension UIViewController {
    func setupBackButton() {
        let backIcon = UIImage(systemName: "chevron.backward")
        let backItem = UIBarButtonItem(image: backIcon, style: .done, target: self, action: #selector(routeToPreviousScreen))
        
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "darkGray")
    }
    
    @objc private func routeToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
}
