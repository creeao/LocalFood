//
//  MapPresenter.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 21/11/2021.
//

import UIKit

final class MapPresenter: MapPresentationSetup {
    weak var viewController: MapDisplayLogic?

    func attach(viewController: MapDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: MapPresentationLogic
extension MapPresenter: MapPresentationLogic {
    func presentContent(response: Map.Content.Response) {
        let viewModel = Map.Content.ViewModel(places: response.places)
        viewController?.displayContent(viewModel: viewModel)
    }
    
    func presentDeliveryStatus(response: Map.DuringDelivery.Response) {
        var deliveryTime = ""
        let cost = "Koszt dostawy to " + String(format: "%.2f", response.order.deliveryCost) + " PLN"
        
        let currentTime = (Date.now + 3600).timeIntervalSinceReferenceDate
        let deliveryEndTime = (response.order.deliveryEndTime ?? Date()).timeIntervalSinceReferenceDate
        let orderTime = (deliveryEndTime - currentTime) / 60.0
        if orderTime < 2.0 {
            deliveryTime = "Na miejscu za " + String(format: "%.0f", orderTime) + " minute"
        } else if orderTime < 5.0 {
            deliveryTime = "Na miejscu za " + String(format: "%.0f", orderTime) + " minuty"
        } else {
            deliveryTime = "Na miejscu za " + String(format: "%.0f", orderTime) + " minut"
        }
        
        let viewModel = Map.DuringDelivery.ViewModel(
            cost: cost,
            deliveryTime: deliveryTime,
            status: response.order.status,
            place: response.order.place)
        viewController?.displayDeliveryStatus(viewModel: viewModel)
    }
}
