//
//  ShoppingCartRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

final class ShoppingCartRouter: ShoppingCartDataPassing {
    weak var delegate: ShoppingCartRoutingLogicDelegate?

    // MARK: ShoppingCartDataPassing

    weak var viewController: ShoppingCartScene?
    weak var dataStore: ShoppingCartDataStore?
}

extension ShoppingCartRouter: ShoppingCartRoutingLogic {
    func routeToMap() {
    }
}
