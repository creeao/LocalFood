//
//  RegistrationContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import UIKit

// MARK: - Interactor

protocol RegistrationBusinessLogic: AnyObject {
    var presenter: RegistrationPresenting? { get }
    func prepareContent(request: Registration.Content.Request)
    func makeOrder(request: Registration.MakeOrder.Request)
}

protocol RegistrationDataStore: class {

}

// MARK: - Presenter

typealias RegistrationPresenting = RegistrationPresentationLogic & RegistrationPresentationSetup

protocol RegistrationPresentationLogic {
    func presentContent(response: Registration.Content.Response)
}

protocol RegistrationPresentationSetup {
    func attach(viewController: RegistrationDisplayLogic)
}

// MARK: - View Controller

protocol RegistrationDisplayLogic: AnyObject {
    func displayContent(viewModel: Registration.Content.ViewModel)
}

// MARK: - Router

typealias RegistrationRouting = RegistrationRoutingLogic & RegistrationDataPassing

protocol RegistrationRoutingLogicDelegate: AnyObject {}

protocol RegistrationRoutingLogic: AnyObject {
    var delegate: RegistrationRoutingLogicDelegate? { get set }
    func routeToMap()
}

typealias RegistrationScene = (UIViewController & RegistrationDisplayLogic)

protocol RegistrationDataPassing: AnyObject {
    var viewController: RegistrationScene? { get set }
    var dataStore: RegistrationDataStore? { get set }
}
