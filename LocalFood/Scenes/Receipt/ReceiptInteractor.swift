//
//  ReceiptInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

final class ReceiptInteractor: ReceiptDataStore {

    // MARK: Properties
    var presenter: ReceiptPresenting?
    var ReceiptId: String?
}

// MARK: ReceiptBusinessLogic
extension ReceiptInteractor: ReceiptBusinessLogic {
    func prepareContent(request: Receipt.Content.Request) {
        guard let order = Orders.shared.getOrders().last else { return }
        let response = Receipt.Content.Response(
            placeName: order.place.name,
            products: order.products,
            orderValue: order.cost + order.deliveryCost)
        presenter?.presentContent(response: response)
    }
}
