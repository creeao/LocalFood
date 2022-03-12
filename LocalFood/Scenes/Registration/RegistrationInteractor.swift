//
//  RegistrationInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import Foundation

final class RegistrationInteractor: RegistrationDataStore {

    // MARK: Properties
    var presenter: RegistrationPresenting?
    var gateway: APIGateway?
    var RegistrationId: String?
}

// MARK: RegistrationBusinessLogic
extension RegistrationInteractor: RegistrationBusinessLogic {
    func prepareContent(request: Registration.Content.Request) {
        let products = Basket.shared.getProducts()
        let response = Registration.Content.Response(products: products)
        presenter?.presentContent(response: response)
    }
    
    func makeOrder(request: Registration.MakeOrder.Request) {
        guard let selectedPlace = Orders.shared.selectedPlace else { return }
        let products = Basket.shared.getProducts()
        Orders.shared.makeOrder(products: products, place: selectedPlace)
    }
}
