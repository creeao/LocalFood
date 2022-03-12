//
//  ReceiptCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

struct ReceiptCreator {
    func getViewController() -> UIViewController {
        let gateway = GatewayInstance()
        let interactor = ReceiptInteractor()
        let presenter = ReceiptPresenter()
        let router = ReceiptRouter()
        let viewController = ReceiptViewController()

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
