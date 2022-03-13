//
//  LoginContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

// MARK: - Interactor

protocol LoginBusinessLogic: AnyObject {
    var presenter: LoginPresenting? { get }
    func login(request: Login.Login.Request)
}

protocol LoginDataStore: class {

}

// MARK: - Presenter

typealias LoginPresenting = LoginPresentationLogic & LoginPresentationSetup

protocol LoginPresentationLogic {
    func presentLoginResult(response: Login.Login.Response)
}

protocol LoginPresentationSetup {
    func attach(viewController: LoginDisplayLogic)
}

// MARK: - View Controller

protocol LoginDisplayLogic: AnyObject {
    func displayLoginResult(viewModel: Login.Login.ViewModel)
}

// MARK: - Router

typealias LoginRouting = LoginRoutingLogic & LoginDataPassing

protocol LoginRoutingLogicDelegate: AnyObject {}

protocol LoginRoutingLogic: AnyObject {
    var delegate: LoginRoutingLogicDelegate? { get set }
    func routeToMap()
}

typealias LoginScene = (UIViewController & LoginDisplayLogic)

protocol LoginDataPassing: AnyObject {
    var viewController: LoginScene? { get set }
    var dataStore: LoginDataStore? { get set }
}
