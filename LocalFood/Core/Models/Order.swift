//
//  Order.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 13/03/2022.
//

import Foundation

struct Order {
    let products: [Product]
    let place: MapPlace
    let distance: Double
    let deliveryStartTime: Date?
    let deliveryEndTime: Date?
    let deliveryCost: Double
    var status: OrderStatus
    var cost: Double
}
