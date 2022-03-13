//
//  MainCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

struct MainCreator {
    func getViewController() -> UIViewController {
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        let viewController = MainViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
