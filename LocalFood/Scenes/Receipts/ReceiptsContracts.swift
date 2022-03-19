//
//  ReceiptsContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

// MARK: - Interactor

protocol ReceiptsBusinessLogic: AnyObject {
    var presenter: ReceiptsPresenting? { get }
    func prepareContent(request: Receipts.Content.Request)
}

protocol ReceiptsDataStore: class {}

// MARK: - Presenter

typealias ReceiptsPresenting = ReceiptsPresentationLogic & ReceiptsPresentationSetup

protocol ReceiptsPresentationLogic {
    func presentContent(response: Receipts.Content.Response)
}

protocol ReceiptsPresentationSetup {
    func attach(viewController: ReceiptsDisplayLogic)
}

// MARK: - View Controller

protocol ReceiptsDisplayLogic: AnyObject {
    func displayContent(viewModel: Receipts.Content.ViewModel)
}

// MARK: - Router

typealias ReceiptsRouting = ReceiptsRoutingLogic & ReceiptsDataPassing

protocol ReceiptsRoutingLogicDelegate: AnyObject {}

protocol ReceiptsRoutingLogic: AnyObject {
    var delegate: ReceiptsRoutingLogicDelegate? { get set }
    func routeToOrderInformation(id: Date?)
}

typealias ReceiptsScene = (UIViewController & ReceiptsDisplayLogic)

protocol ReceiptsDataPassing: AnyObject {
    var viewController: ReceiptsScene? { get set }
    var dataStore: ReceiptsDataStore? { get set }
}
