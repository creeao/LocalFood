//
//  ProductType.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 13/03/2022.
//

import Foundation

enum ProductType {
    case kilograms
    case liters
}

extension ProductType {
    var description: String {
        switch self {
        case .kilograms:
            return "kg"
        case .liters:
            return "l"
        }
    }
}
