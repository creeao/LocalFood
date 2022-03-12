//
//  APIResponse.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import Foundation

protocol APIResponse {
    associatedtype ResponseType
    func response(for data: Data) throws -> ResponseType
}

protocol APIRequest {
    associatedtype RequestType
    func request(for data: Data) throws -> RequestType
}

