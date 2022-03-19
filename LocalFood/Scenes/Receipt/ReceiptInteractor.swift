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
    var id: Date?
    
    init(id: Date?) {
        self.id = id
    }
}

// MARK: ReceiptBusinessLogic
extension ReceiptInteractor: ReceiptBusinessLogic {
    func prepareContent(request: Receipt.Content.Request) {
        if let order = Orders.shared.getOrders().first(where: { $0.deliveryStartTime == id }) {
            let response = Receipt.Content.Response(
                placeName: order.place.name,
                products: order.products,
                orderValue: order.cost + order.deliveryCost)
            presenter?.presentContent(response: response)
        } else if let order = Orders.shared.getOrders().last {
            let response = Receipt.Content.Response(
                placeName: order.place.name,
                products: order.products,
                orderValue: order.cost + order.deliveryCost)
            presenter?.presentContent(response: response)
        }
    }
}
