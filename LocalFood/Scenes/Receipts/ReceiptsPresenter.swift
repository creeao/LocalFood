//
//  ReceiptsPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

final class ReceiptsPresenter: ReceiptsPresentationSetup {
    weak var viewController: ReceiptsDisplayLogic?

    func attach(viewController: ReceiptsDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: ReceiptsPresentationLogic
extension ReceiptsPresenter: ReceiptsPresentationLogic {
    func presentContent(response: Receipts.Content.Response) {
        let orders: [ReceiptItem] = response.orders.compactMap { ReceiptItem(
            placeName: $0.place.name,
            cost: String(format: "%.2f", $0.cost) + " PLN",
            date: $0.deliveryStartTime?.yyMMdd ?? "",
            id: $0.deliveryStartTime) }
        
        viewController?.displayContent(viewModel: .init(orders: orders))
    }
}

