//
//  EditProfileCreator.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

struct EditProfileCreator {
    func getViewController() -> UIViewController {
        let interactor = EditProfileInteractor()
        let presenter = EditProfilePresenter()
        let router = EditProfileRouter()
        let viewController = EditProfileViewController()

        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)

        return viewController
    }
}
