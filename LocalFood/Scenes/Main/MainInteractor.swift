//
//  MainInteractor.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

final class MainInteractor: MainDataStore {
    // MARK: Properties
    var presenter: MainPresenting?
}

// MARK: MainBusinessLogic
extension MainInteractor: MainBusinessLogic {}
