//
//  ShoppingCartCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

struct ShoppingCartCreator {
    func getViewController() -> UIViewController {
        let interactor = ShoppingCartInteractor()
        let presenter = ShoppingCartPresenter()
        let router = ShoppingCartRouter()
        let viewController = ShoppingCartViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
