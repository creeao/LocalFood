//
//  Order.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 05/03/2022.
//

import Foundation
import MapKit

class Orders {
    static let shared = Orders()
    
    private var userOrders: [Order] = []
    var selectedPlace: MapPlace?
    var polyline: MKPolyline?
    var distance: Double?
    var time: Double?
    
    private init() {}
    
    func makeOrder(products: [Product], place: MapPlace) {
        let current = Date.now + 3600
        let deliveryTime: TimeInterval = distance ?? 0.0
        
        let order = Order(
            products: products,
            place: place,
            distance: distance ?? 0.0,
            deliveryStartTime: current,
            deliveryEndTime: current + deliveryTime,
            status: .packed)
        userOrders.append(order)
    }

    func getLastOrder() -> Order? {
        userOrders.last
    }
    
    func getOrders() -> [Order] {
        userOrders
    }

    func checkOrderStatus() -> OrderStatus {
        userOrders.last?.status ?? .none
    }
}

struct Order {
    let products: [Product]
    let place: MapPlace
    let distance: Double
    let deliveryStartTime: Date?
    let deliveryEndTime: Date?
    var status: OrderStatus
}

enum OrderStatus {
    case none
    case packed
    case delivery
    case done
}

extension OrderStatus {
    var text: String {
        switch self {
        case .packed:
            return "Zamówienie jest pakowane"
        case .delivery:
            return "Zamówienie jest w drodze"
        case .done:
            return "Zamówienie zostało dostarczone"
        default:
            return ""
        }
    }
}
