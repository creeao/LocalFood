//
//  Basket.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 02/03/2022.
//

import Foundation

class Basket {
    private var products: [Product] = []
    static let shared = Basket()
    
    private init() {}
    
    func addProduct(_ newProduct: Product) {
        products.append(newProduct)
    }
    
    func getProducts() -> [Product] {
        products
    }
    
    func getTotalPrice() -> Double {
        var price: Double = 0.0
        products.forEach { price += $0.price }
        return price
    }
    
    func removeProduct(with name: String) {
        guard let product = products.firstIndex(where: { $0.name == name }) else { return }
        products.remove(at: product)
    }
}
