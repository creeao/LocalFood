//
//  MainModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

enum Main {
    enum Main {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let isMainSuccessfull: Bool
        }
        
        struct ViewModel {
            let isMainSuccessfull: Bool
        }
    }
}
