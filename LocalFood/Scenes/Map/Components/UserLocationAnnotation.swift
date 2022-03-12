//
//  UserLocationAnnotation.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import MapKit

class UserLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
