//
//  ReceiptsInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

final class ReceiptsInteractor: ReceiptsDataStore {
    // MARK: Properties
    var presenter: ReceiptsPresenting?
}

// MARK: ReceiptsBusinessLogic
extension ReceiptsInteractor: ReceiptsBusinessLogic {
    func prepareContent(request: Receipts.Content.Request) {
        presenter?.presentContent(response: .init(orders: Orders.shared.getOrders()))
    }
}
