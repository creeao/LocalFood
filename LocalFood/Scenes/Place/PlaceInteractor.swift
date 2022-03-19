//
//  PlaceInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import Foundation

final class PlaceInteractor: PlaceDataStore {

    // MARK: Properties
    var presenter: PlacePresenting?
    var placeId: String?
}

// MARK: PlaceBusinessLogic
extension PlaceInteractor: PlaceBusinessLogic {
    func prepareContent(request: Place.Content.Request) {
        let products = Mock.shared.getProducts()
        let place = SelectedPlace(id: "1", name: "Domowa Kuchnia", description: "Restauracja", products: products)
        presenter?.presentContent(response: .init(place: place))
    }
}
