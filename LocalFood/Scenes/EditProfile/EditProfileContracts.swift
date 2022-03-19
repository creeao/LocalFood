//
//  EditProfileContracts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

// MARK: - Interactor

protocol EditProfileBusinessLogic: AnyObject {
    var presenter: EditProfilePresenting? { get }
    func prepareContent(request: EditProfile.Content.Request)
    func edit(request: EditProfile.Edit.Request)
}

protocol EditProfileDataStore: class {

}

// MARK: - Presenter

typealias EditProfilePresenting = EditProfilePresentationLogic & EditProfilePresentationSetup

protocol EditProfilePresentationLogic {
    func presentContent(response: EditProfile.Content.Response)
    func presentEditResult(response: EditProfile.Edit.Response)
}

protocol EditProfilePresentationSetup {
    func attach(viewController: EditProfileDisplayLogic)
}

// MARK: - View Controller

protocol EditProfileDisplayLogic: AnyObject {
    func displayContent(viewModel: EditProfile.Content.ViewModel)
    func displayEditResult(viewModel: EditProfile.Edit.ViewModel)
}

// MARK: - Router

typealias EditProfileRouting = EditProfileRoutingLogic & EditProfileDataPassing

protocol EditProfileRoutingLogicDelegate: AnyObject {}

protocol EditProfileRoutingLogic: AnyObject {
    var delegate: EditProfileRoutingLogicDelegate? { get set }
}

typealias EditProfileScene = (UIViewController & EditProfileDisplayLogic)

protocol EditProfileDataPassing: AnyObject {
    var viewController: EditProfileScene? { get set }
    var dataStore: EditProfileDataStore? { get set }
}
