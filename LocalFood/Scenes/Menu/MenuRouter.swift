//
//  MenuRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import Foundation

final class MenuRouter: MenuDataPassing {
    weak var delegate: MenuRoutingLogicDelegate?

    // MARK: MenuDataPassing

    weak var viewController: MenuScene?
    weak var dataStore: MenuDataStore?
}

extension MenuRouter: MenuRoutingLogic {
    func routeToOrders() {
        
    }
    
    func routeToEditProfile() {
//        let registerViewController = RegistrationCreator().getViewController()
//        viewController?.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func routeToLogout() {
        Accounts.shared.logout()
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
