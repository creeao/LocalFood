//
//  MenuInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import Foundation

final class MenuInteractor: MenuDataStore {
    // MARK: Properties
    var presenter: MenuPresenting?
}

// MARK: MenuBusinessLogic
extension MenuInteractor: MenuBusinessLogic {
    func prepareContent(request: Menu.Content.Request) {
        guard let account = Accounts.shared.getLoginAccount() else { return }
        presenter?.presentContent(response: .init(account: account))
    }
}
