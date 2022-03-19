//
//  EditProfileRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

final class EditProfileRouter: EditProfileDataPassing {
    weak var delegate: EditProfileRoutingLogicDelegate?

    // MARK: EditProfileDataPassing

    weak var viewController: EditProfileScene?
    weak var dataStore: EditProfileDataStore?
}

extension EditProfileRouter: EditProfileRoutingLogic {
    func routeToMap() {
    }
}
