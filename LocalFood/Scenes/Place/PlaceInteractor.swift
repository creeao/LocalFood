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
        // TODO: Request wykorzystujący id które przychodzi
        let products = [Product(name: "Mleko", price: 2.60), Product(name: "Ser", price: 4.20)]
        let categories = [Category(name: "Nabiał", products: products)]
        let place = SelectedPlace(id: "1", name: "Domowa Kuchnia", description: "Restauracja", categories: categories)
        let response = Place.Content.Response(place: place)
        presenter?.presentContent(response: response)
    }
}
