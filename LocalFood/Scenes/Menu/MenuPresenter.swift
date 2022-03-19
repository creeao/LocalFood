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
    func presentContent(response: Menu.Content.Response) {}
}
