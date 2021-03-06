//
//  RegistrationCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import UIKit

struct RegistrationCreator {
    func getViewController() -> UIViewController {
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
        let viewController = RegistrationViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
