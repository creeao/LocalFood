//
//  OrderStatus.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 13/03/2022.
//

import Foundation

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
