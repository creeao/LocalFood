//
//  MainContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import UIKit

// MARK: - Interactor

protocol MainBusinessLogic: AnyObject {
    var presenter: MainPresenting? { get }
}

protocol MainDataStore: class {}

// MARK: - Presenter

typealias MainPresenting = MainPresentationLogic & MainPresentationSetup

protocol MainPresentationLogic {}

protocol MainPresentationSetup {
    func attach(viewController: MainDisplayLogic)
}

// MARK: - View Controller

protocol MainDisplayLogic: AnyObject {}

// MARK: - Router

typealias MainRouting = MainRoutingLogic & MainDataPassing

protocol MainRoutingLogicDelegate: AnyObject {}

protocol MainRoutingLogic: AnyObject {
    var delegate: MainRoutingLogicDelegate? { get set }
    func routeToLogin()
    func routeToRegister()
}

typealias MainScene = (UIViewController & MainDisplayLogic)

protocol MainDataPassing: AnyObject {
    var viewController: MainScene? { get set }
    var dataStore: MainDataStore? { get set }
}
