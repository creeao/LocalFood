//
//  PlaceModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 28/11/2021.
//

import Foundation

enum Place {
    enum Content {
        struct Request {

        }

        struct Response {
            let place: SelectedPlace
        }

        struct ViewModel {
            let place: SelectedPlace
        }
    }
}
