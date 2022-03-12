//
//  RegistrationRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import Foundation

final class RegistrationRouter: RegistrationDataPassing {
    weak var delegate: RegistrationRoutingLogicDelegate?

    // MARK: RegistrationDataPassing

    weak var viewController: RegistrationScene?
    weak var dataStore: RegistrationDataStore?
}

extension RegistrationRouter: RegistrationRoutingLogic {
    func routeToMap() {
    }
}
