//
//  MainPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

final class MainPresenter: MainPresentationSetup {
    weak var viewController: MainDisplayLogic?

    func attach(viewController: MainDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: MainPresentationLogic
extension MainPresenter: MainPresentationLogic {}
