//
//  APIGateway.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import Foundation

protocol APIGateway: class {
    func makeRequest<T: Decodable>(model: T.Type, url: String, completion: @escaping (T) -> Void)
    func createRequest(parameters: [String : String], url: String)
}
