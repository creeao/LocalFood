//
//  LoginRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

final class LoginRouter: LoginDataPassing {
    weak var delegate: LoginRoutingLogicDelegate?

    // MARK: LoginDataPassing

    weak var viewController: LoginScene?
    weak var dataStore: LoginDataStore?
}

extension LoginRouter: LoginRoutingLogic {
    func routeToMap() {
        let mapViewController = MapCreator().getViewController()
        viewController?.navigationController?.pushViewController(mapViewController, animated: true)
    }
}
