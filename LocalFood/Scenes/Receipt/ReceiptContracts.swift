//
//  ReceiptContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import UIKit

// MARK: - Interactor

protocol ReceiptBusinessLogic: AnyObject {
    var presenter: ReceiptPresenting? { get }
    func prepareContent(request: Receipt.Content.Request)
}

protocol ReceiptDataStore: class {

}

// MARK: - Presenter

typealias ReceiptPresenting = ReceiptPresentationLogic & ReceiptPresentationSetup

protocol ReceiptPresentationLogic {
    func presentContent(response: Receipt.Content.Response)
}

protocol ReceiptPresentationSetup {
    func attach(viewController: ReceiptDisplayLogic)
}

// MARK: - View Controller

protocol ReceiptDisplayLogic: class {
    func displayContent(viewModel: Receipt.Content.ViewModel)
}

// MARK: - Router

typealias ReceiptRouting = ReceiptRoutingLogic & ReceiptDataPassing

protocol ReceiptRoutingLogicDelegate: class {}

protocol ReceiptRoutingLogic: class {
    var delegate: ReceiptRoutingLogicDelegate? { get set }
//    func routeToMap()
}

typealias ReceiptScene = (UIViewController & ReceiptDisplayLogic)

protocol ReceiptDataPassing: class {
    var viewController: ReceiptScene? { get set }
    var dataStore: ReceiptDataStore? { get set }
}
