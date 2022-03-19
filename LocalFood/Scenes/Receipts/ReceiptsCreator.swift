//
//  ReceiptsCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

struct ReceiptsCreator {
    func getViewController() -> UIViewController {
        let interactor = ReceiptsInteractor()
        let presenter = ReceiptsPresenter()
        let router = ReceiptsRouter()
        let viewController = ReceiptsViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
