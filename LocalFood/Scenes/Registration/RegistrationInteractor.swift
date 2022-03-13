//
//  RegistrationInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import Foundation

final class RegistrationInteractor: RegistrationDataStore {
    // MARK: Properties
    var presenter: RegistrationPresenting?
}

// MARK: RegistrationBusinessLogic
extension RegistrationInteractor: RegistrationBusinessLogic {
    func register(request: Registration.Register.Request) {
        if Accounts.shared.accountExist(email: request.data.email) {
            presenter?.presentRegisterResult(response: .init(isRegisterSuccessfull: false))
        } else {
            Accounts.shared.addAccount(request.data)
            presenter?.presentRegisterResult(response: .init(isRegisterSuccessfull: true))
        }
    }
}
