//
//  LoginModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

enum Login {
    enum Login {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let isLoginSuccessfull: Bool
        }
        
        struct ViewModel {
            let isLoginSuccessfull: Bool
        }
    }
}
