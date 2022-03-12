//
//  MapModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import Foundation

enum Map {
    enum Content {
        struct Request {
            
        }

        struct Response {
            let places: [MapPlace]
        }

        struct ViewModel {
            let places: [MapPlace]
        }
    }
    
    enum DuringDelivery {
        struct Request {
            
        }
        
        struct Response {
            let order: Order
        }
        
        struct ViewModel {
            let cost: String
            let deliveryTime: String
            let status: OrderStatus
            let place: MapPlace
        }
    }
}
