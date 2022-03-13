//
//  RegistrationModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import Foundation

enum Registration {
    enum Register {
        struct Request {
            let data: Account
        }
        
        struct Response {
            let isRegisterSuccessfull: Bool
        }
        
        struct ViewModel {
            let isRegisterSuccessfull: Bool
        }
    }
}
