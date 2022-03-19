//
//  MenuCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import UIKit

struct MenuCreator {
    func getViewController() -> UIViewController {
        let interactor = MenuInteractor()
        let presenter = MenuPresenter()
        let router = MenuRouter()
        let viewController = MenuViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
