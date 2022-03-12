//
//  PlaceCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import UIKit

struct PlaceCreator {
    func getViewController() -> UIViewController {
        let gateway = GatewayInstance()
        let interactor = PlaceInteractor()
        let presenter = PlacePresenter()
        let router = PlaceRouter()
        let viewController = PlaceViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.gateway = gateway
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
