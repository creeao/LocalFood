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
    func presentRegisterResult(response: Registration.Register.Response) {
        viewController?.displayRegisterResult(viewModel: .init(isRegisterSuccessfull: response.isRegisterSuccessfull))
    }
}
