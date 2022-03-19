//
//  EditProfileInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

final class EditProfileInteractor: EditProfileDataStore {
    // MARK: Properties
    var presenter: EditProfilePresenting?
}

// MARK: EditProfileBusinessLogic
extension EditProfileInteractor: EditProfileBusinessLogic {
    func prepareContent(request: EditProfile.Content.Request) {
        guard let account = Accounts.shared.getLoginAccount() else { return }
        presenter?.presentContent(response: .init(data: account))
    }
    
    func edit(request: EditProfile.Edit.Request) {
        presenter?.presentEditResult(response: .init(isEditSuccessfull: Accounts.shared.editData(request.data)))
    }
}
