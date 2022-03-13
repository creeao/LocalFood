//
//  ShoppingCartInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

final class ShoppingCartInteractor: ShoppingCartDataStore {

    // MARK: Properties
    var presenter: ShoppingCartPresenting?
    var ShoppingCartId: String?
}

// MARK: ShoppingCartBusinessLogic
extension ShoppingCartInteractor: ShoppingCartBusinessLogic {
    func prepareContent(request: ShoppingCart.Content.Request) {
        let products = Basket.shared.getProducts()
        let response = ShoppingCart.Content.Response(products: products)
        presenter?.presentContent(response: response)
    }
    
    func makeOrder(request: ShoppingCart.MakeOrder.Request) {
        guard let selectedPlace = Orders.shared.selectedPlace else { return }
        let products = Basket.shared.getProducts()
        Orders.shared.makeOrder(products: products, place: selectedPlace)
    }
}
