//
//  MenuContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import UIKit

// MARK: - Interactor

protocol MenuBusinessLogic: AnyObject {
    var presenter: MenuPresenting? { get }
    func prepareContent(request: Menu.Content.Request)
}

protocol MenuDataStore: class {}

// MARK: - Presenter

typealias MenuPresenting = MenuPresentationLogic & MenuPresentationSetup

protocol MenuPresentationLogic {
    func presentContent(response: Menu.Content.Response)
}

protocol MenuPresentationSetup {
    func attach(viewController: MenuDisplayLogic)
}

// MARK: - View Controller

protocol MenuDisplayLogic: AnyObject {
    func displayContent(viewModel: Menu.Content.ViewModel)
}

// MARK: - Router

typealias MenuRouting = MenuRoutingLogic & MenuDataPassing

protocol MenuRoutingLogicDelegate: AnyObject {}

protocol MenuRoutingLogic: AnyObject {
    var delegate: MenuRoutingLogicDelegate? { get set }
    func routeToOrders()
    func routeToEditProfile()
    func routeToLogout()
}

typealias MenuScene = (UIViewController & MenuDisplayLogic)

protocol MenuDataPassing: AnyObject {
    var viewController: MenuScene? { get set }
    var dataStore: MenuDataStore? { get set }
}
