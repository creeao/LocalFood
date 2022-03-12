//
//  PlaceRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import Foundation

final class PlaceRouter: PlaceDataPassing {
    weak var delegate: PlaceRoutingLogicDelegate?

    // MARK: PlaceDataPassing

    weak var viewController: PlaceScene?
    weak var dataStore: PlaceDataStore?
}

extension PlaceRouter: PlaceRoutingLogic {
    func routeToShoppingCart() {
        let shoppingCartViewController = ShoppingCartCreator().getViewController()
        viewController?.navigationController?.pushViewController(shoppingCartViewController, animated: true)
    }
}
