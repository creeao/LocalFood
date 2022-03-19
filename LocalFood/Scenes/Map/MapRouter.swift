//
//  MapRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 21/11/2021.
//

import Foundation

final class MapRouter: MapDataPassing {
    weak var delegate: MapRoutingLogicDelegate?

    // MARK: MapDataPassing

    weak var viewController: MapScene?
    weak var dataStore: MapDataStore?
}

extension MapRouter: MapRoutingLogic {
    func routeToPlace() {
        let placeViewController = PlaceCreator().getViewController()
        viewController?.navigationController?.pushViewController(placeViewController, animated: true)
    }
    
    func routeToReceipt() {
        let receiptViewController = ReceiptCreator().getViewController(id: nil)
        viewController?.navigationController?.pushViewController(receiptViewController, animated: true)
    }
    
    func routeToMenu() {
        let menuViewController = MenuCreator().getViewController()
        viewController?.navigationController?.pushViewController(menuViewController, animated: true)
    }
}
