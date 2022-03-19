//
//  EditProfilePresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

final class EditProfilePresenter: EditProfilePresentationSetup {
    weak var viewController: EditProfileDisplayLogic?

    func attach(viewController: EditProfileDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: EditProfilePresentationLogic
extension EditProfilePresenter: EditProfilePresentationLogic {
    func presentContent(response: EditProfile.Content.Response) {
        viewController?.displayContent(viewModel: .init(data: response.data))
    }
    
    func presentEditResult(response: EditProfile.Edit.Response) {
        viewController?.displayEditResult(viewModel: .init(isEditSuccessfull: response.isEditSuccessfull))
    }
}
