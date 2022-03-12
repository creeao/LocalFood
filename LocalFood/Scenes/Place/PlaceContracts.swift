//
//  PlaceContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import UIKit

// MARK: - Interactor

protocol PlaceBusinessLogic: AnyObject {
    var presenter: PlacePresenting? { get }
    func prepareContent(request: Place.Content.Request)
}

protocol PlaceDataStore: class {

}

// MARK: - Presenter

typealias PlacePresenting = PlacePresentationLogic & PlacePresentationSetup

protocol PlacePresentationLogic {
    func presentContent(response: Place.Content.Response)
}

protocol PlacePresentationSetup {
    func attach(viewController: PlaceDisplayLogic)
}

// MARK: - View Controller

protocol PlaceDisplayLogic: class {
    func displayContent(viewModel: Place.Content.ViewModel)
}

// MARK: - Router

typealias PlaceRouting = PlaceRoutingLogic & PlaceDataPassing

protocol PlaceRoutingLogicDelegate: class {}

protocol PlaceRoutingLogic: class {
    var delegate: PlaceRoutingLogicDelegate? { get set }
    func routeToShoppingCart()
}

typealias PlaceScene = (UIViewController & PlaceDisplayLogic)

protocol PlaceDataPassing: class {
    var viewController: PlaceScene? { get set }
    var dataStore: PlaceDataStore? { get set }
}
