//
//  JSONResponse.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import Foundation

struct JSONResponse<Response: Decodable>: APIResponse {
    typealias ResponseType = Response

    func response(for data: Data) throws -> ResponseType {
        let decoder = JSONDecoder()
        return try decoder.decode(ResponseType.self, from: data)
    }
}
