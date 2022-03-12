//
//  PlacePresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import UIKit

final class PlacePresenter: PlacePresentationSetup {
    weak var viewController: PlaceDisplayLogic?

    func attach(viewController: PlaceDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: PlacePresentationLogic
extension PlacePresenter: PlacePresentationLogic {
    func presentContent(response: Place.Content.Response) {
        let viewModel = Place.Content.ViewModel(place: response.place)
        viewController?.displayContent(viewModel: viewModel)
    }
}
