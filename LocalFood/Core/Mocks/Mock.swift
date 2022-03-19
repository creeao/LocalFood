//
//  Mock.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 13/03/2022.
//

import Foundation

final class Mock {
    static let shared = Mock()

    private init() {}
    
    func getProducts() -> [Product] {
        let mlik = Product(
            name: "Mleko",
            price: 3.29,
            quantity: 1.0,
            type: .liters)
        
        let cheese = Product(
            name: "Ser",
            price: 4.99,
            quantity: 0.150,
            type: .kilograms)
        
        let cola = Product(
            name: "Cola",
            price: 3.99,
            quantity: 1.5,
            type: .liters)
        
        let water = Product(
            name: "Woda",
            price: 1.89,
            quantity: 2.0,
            type: .liters)
        
        return [mlik, cheese, cola, water]
    }
}
