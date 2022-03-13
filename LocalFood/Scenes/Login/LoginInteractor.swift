//
//  LoginInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

final class LoginInteractor: LoginDataStore {
    // MARK: Properties
    var presenter: LoginPresenting?
}

// MARK: LoginBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    func login(request: Login.Login.Request) {
        if Accounts.shared.login(email: request.email, password: request.password) {
            presenter?.presentLoginResult(response: .init(isLoginSuccessfull: true))
        } else {
            presenter?.presentLoginResult(response: .init(isLoginSuccessfull: false))
        }
    }
}
