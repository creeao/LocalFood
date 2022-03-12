//
//  RegistrationModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 10/03/2022.
//

import Foundation

enum Registration {
    enum Content {
        struct Request {

        }

        struct Response {
            let products: [Product]
        }

        struct ViewModel {
            let products: [Product]
        }
    }
    
    enum MakeOrder {
        struct Request {

        }
    }
}
