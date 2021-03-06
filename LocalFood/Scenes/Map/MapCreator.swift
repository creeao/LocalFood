//
//  MapControllerCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 21/11/2021.
//

import UIKit

struct MapCreator {
    func getViewController() -> UIViewController {
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        let viewController = MapViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
