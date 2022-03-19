//
//  Date.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

extension Date {
    var yyMMdd: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
