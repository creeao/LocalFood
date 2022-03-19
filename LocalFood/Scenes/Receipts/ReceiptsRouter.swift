//
//  ReceiptsRouter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

final class ReceiptsRouter: ReceiptsDataPassing {
    weak var delegate: ReceiptsRoutingLogicDelegate?

    // MARK: ReceiptsDataPassing

    weak var viewController: ReceiptsScene?
    weak var dataStore: ReceiptsDataStore?
}

extension ReceiptsRouter: ReceiptsRoutingLogic {
    func routeToOrderInformation(id: Date?) {
        let receiptViewController = ReceiptCreator().getViewController(id: id)
        viewController?.navigationController?.pushViewController(receiptViewController, animated: true)
    }
}
