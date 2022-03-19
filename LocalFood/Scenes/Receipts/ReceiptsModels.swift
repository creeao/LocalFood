//
//  ReceiptsModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

enum Receipts {
    enum Content {
        struct Request {
            
        }
        
        struct Response {
            let orders: [Order]
        }
        
        struct ViewModel {
            let orders: [ReceiptItem]
        }
    }
}
