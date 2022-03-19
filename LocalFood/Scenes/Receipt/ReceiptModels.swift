//
//  ReceiptModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

enum Receipt {
    enum Content {
        struct Request {

        }

        struct Response {
            let placeName: String
            let products: [Product]
            let orderValue: Double
        }

        struct ViewModel {
            let placeName: String
            let products: [Product]
            let orderValue: Double
        }
    }
}
