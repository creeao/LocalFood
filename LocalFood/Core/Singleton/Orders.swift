//
//  Order.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 05/03/2022.
//

import MapKit

class Orders {
    static let shared = Orders()
    
    private var userOrders: [Order] = []
    private var selectedPlace: MapPlace?
    private var polyline: MKPolyline?
    private var distance: Double?
    private var time: Double?
    
    private init() {}
    
    func makeOrder(products: [Product], place: MapPlace) {
        let current = Date.now + 3600
        let deliveryTime: TimeInterval = distance ?? 0.0
        
        var cost: Double = 0.0
        products.forEach { cost += $0.price }
        
        let order = Order(
            products: products,
            place: place,
            distance: distance ?? 0.0,
            deliveryStartTime: current,
            deliveryEndTime: current + deliveryTime,
            deliveryCost: (distance ?? 0.0) / 500.0,
            status: .packed,
            cost: cost)
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
    
    func setSelectedPlace(place: MapPlace?) {
        selectedPlace = place
    }
    
    func getSelectedPlace() -> MapPlace? {
        selectedPlace
    }
    
    func setPolyline(_ newPolyline: MKPolyline?) {
        polyline = newPolyline
    }
    
    func getPolyline() -> MKPolyline? {
        polyline
    }
    
    func setDistance(_ newDistance: Double?) {
        distance = newDistance
    }
    
    func getDistance() -> Double? {
        distance
    }
    
    func setTime(_ newTime: Double?) {
        time = newTime
    }
    
    func getTime() -> Double? {
        time
    }
}
