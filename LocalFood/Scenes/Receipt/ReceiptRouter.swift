//
//  ReceiptRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

final class ReceiptRouter: ReceiptDataPassing {
    weak var delegate: ReceiptRoutingLogicDelegate?

    // MARK: ReceiptDataPassing

    weak var viewController: ReceiptScene?
    weak var dataStore: ReceiptDataStore?
}

extension ReceiptRouter: ReceiptRoutingLogic {
//    func routeToMap() {
//    }
}
