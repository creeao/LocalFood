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
}
