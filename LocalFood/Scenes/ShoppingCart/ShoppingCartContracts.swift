//
//  ShoppingCartContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

// MARK: - Interactor

protocol ShoppingCartBusinessLogic: AnyObject {
    var presenter: ShoppingCartPresenting? { get }
    func prepareContent(request: ShoppingCart.Content.Request)
    func makeOrder(request: ShoppingCart.MakeOrder.Request)
}

protocol ShoppingCartDataStore: class {

}

// MARK: - Presenter

typealias ShoppingCartPresenting = ShoppingCartPresentationLogic & ShoppingCartPresentationSetup

protocol ShoppingCartPresentationLogic {
    func presentContent(response: ShoppingCart.Content.Response)
}

protocol ShoppingCartPresentationSetup {
    func attach(viewController: ShoppingCartDisplayLogic)
}

// MARK: - View Controller

protocol ShoppingCartDisplayLogic: AnyObject {
    func displayContent(viewModel: ShoppingCart.Content.ViewModel)
}

// MARK: - Router

typealias ShoppingCartRouting = ShoppingCartRoutingLogic & ShoppingCartDataPassing

protocol ShoppingCartRoutingLogicDelegate: AnyObject {}

protocol ShoppingCartRoutingLogic: AnyObject {
    var delegate: ShoppingCartRoutingLogicDelegate? { get set }
    func routeToMap()
}

typealias ShoppingCartScene = (UIViewController & ShoppingCartDisplayLogic)

protocol ShoppingCartDataPassing: AnyObject {
    var viewController: ShoppingCartScene? { get set }
    var dataStore: ShoppingCartDataStore? { get set }
}
