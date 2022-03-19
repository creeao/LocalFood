//
//  PlaceCategory.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/12/2021.
//

import Foundation

enum PlaceCategory {
    case shop
}

extension PlaceCategory {
    var name: String {
        switch self {
        case .shop:
            return "Sklep spożywczy"
        }
    }
}
