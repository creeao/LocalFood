//
//  ReceiptPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

final class ReceiptPresenter: ReceiptPresentationSetup {
    weak var viewController: ReceiptDisplayLogic?

    func attach(viewController: ReceiptDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: ReceiptPresentationLogic
extension ReceiptPresenter: ReceiptPresentationLogic {
    func presentContent(response: Receipt.Content.Response) {
        viewController?.displayContent(viewModel: .init(
            placeName: response.placeName,
            products: response.products,
            orderValue: response.orderValue))
    }
}
