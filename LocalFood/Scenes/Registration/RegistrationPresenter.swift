//
//  RegistrationPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import UIKit

final class RegistrationPresenter: RegistrationPresentationSetup {
    weak var viewController: RegistrationDisplayLogic?

    func attach(viewController: RegistrationDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: RegistrationPresentationLogic
extension RegistrationPresenter: RegistrationPresentationLogic {
    func presentContent(response: Registration.Content.Response) {
        let viewModel = Registration.Content.ViewModel(products: response.products)
        viewController?.displayContent(viewModel: viewModel)
    }
}
