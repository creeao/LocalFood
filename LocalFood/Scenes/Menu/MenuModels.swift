//
//  MenuModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 16/03/2022.
//

import Foundation

enum Menu {
    enum Content {
        struct Request {
            
        }
        
        struct Response {
            let account: Account
        }
        
        struct ViewModel {
            let name: String
            let email: String
        }
    }
}
