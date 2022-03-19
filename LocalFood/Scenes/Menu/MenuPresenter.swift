//
//  MenuPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import Foundation

final class MenuPresenter: MenuPresentationSetup {
    weak var viewController: MenuDisplayLogic?

    func attach(viewController: MenuDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: MenuPresentationLogic
extension MenuPresenter: MenuPresentationLogic {
    func presentContent(response: Menu.Content.Response) {
        let name = response.account.name + " " + response.account.surname
        let email = response.account.email
        viewController?.displayContent(viewModel: .init(name: name, email: email))
    }
}
