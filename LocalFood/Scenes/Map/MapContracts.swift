//
//  MapContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import UIKit

// MARK: - Interactor

protocol MapBusinessLogic: AnyObject {
    var presenter: MapPresenting? { get }
    func prepareContent(request: Map.Content.Request)
    func prepareDeliveryStatus(request: Map.DuringDelivery.Request)
}

protocol MapDataStore: class {

}

// MARK: - Presenter

typealias MapPresenting = MapPresentationLogic & MapPresentationSetup

protocol MapPresentationLogic {
    func presentContent(response: Map.Content.Response)
    func presentDeliveryStatus(response: Map.DuringDelivery.Response)
}

protocol MapPresentationSetup {
    func attach(viewController: MapDisplayLogic)
}

// MARK: - View Controller

protocol MapDisplayLogic: class {
    func displayContent(viewModel: Map.Content.ViewModel)
    func displayDeliveryStatus(viewModel: Map.DuringDelivery.ViewModel)
}

// MARK: - Router

typealias MapRouting = MapRoutingLogic & MapDataPassing

protocol MapRoutingLogicDelegate: class {}

protocol MapRoutingLogic: class {
    var delegate: MapRoutingLogicDelegate? { get set }
    func routeToPlace()
}

typealias MapScene = (UIViewController & MapDisplayLogic)

protocol MapDataPassing: class {
    var viewController: MapScene? { get set }
    var dataStore: MapDataStore? { get set }
}
