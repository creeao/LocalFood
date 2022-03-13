//
//  MainRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

final class MainRouter: MainDataPassing {
    weak var delegate: MainRoutingLogicDelegate?

    // MARK: MainDataPassing

    weak var viewController: MainScene?
    weak var dataStore: MainDataStore?
}

extension MainRouter: MainRoutingLogic {
    func routeToLogin() {
        let loginViewController = LoginCreator().getViewController()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func routeToRegister() {
        let registerViewController = RegistrationCreator().getViewController()
        viewController?.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
