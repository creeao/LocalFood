//
//  ShoppingCartPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

final class ShoppingCartPresenter: ShoppingCartPresentationSetup {
    weak var viewController: ShoppingCartDisplayLogic?

    func attach(viewController: ShoppingCartDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: ShoppingCartPresentationLogic
extension ShoppingCartPresenter: ShoppingCartPresentationLogic {
    func presentContent(response: ShoppingCart.Content.Response) {
        let viewModel = ShoppingCart.Content.ViewModel(products: response.products)
        viewController?.displayContent(viewModel: viewModel)
    }
}
