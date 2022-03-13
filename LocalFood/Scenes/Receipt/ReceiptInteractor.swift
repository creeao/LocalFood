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
        // TODO: Request wykorzystujący id które przychodzi
        let products = [Product(name: "Mleko", price: 2.60), Product(name: "Ser", price: 4.20)]
        let response = Receipt.Content.Response(products: products)
        presenter?.presentContent(response: response)
    }
}
