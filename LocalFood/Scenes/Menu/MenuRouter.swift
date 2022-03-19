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
        let receiptsViewController = ReceiptsCreator().getViewController()
        viewController?.navigationController?.pushViewController(receiptsViewController, animated: true)
    }
    
    func routeToEditProfile() {
        let editProfileViewController = EditProfileCreator().getViewController()
        viewController?.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    func routeToLogout() {
        Accounts.shared.logout()
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
