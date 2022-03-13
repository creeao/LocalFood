//
//  LoginPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

final class LoginPresenter: LoginPresentationSetup {
    weak var viewController: LoginDisplayLogic?

    func attach(viewController: LoginDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: LoginPresentationLogic
extension LoginPresenter: LoginPresentationLogic {
    func presentLoginResult(response: Login.Login.Response) {
        viewController?.displayLoginResult(viewModel: .init(isLoginSuccessfull: response.isLoginSuccessfull))
    }
}
