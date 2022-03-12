//
//  GatewayInstance.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 27/11/2021.
//

import Foundation
import Combine

class GatewayInstance: NSObject, APIGateway {

    // MARK: - Initialization

    public required override init() {
        super.init()
    }

    typealias Handler = (Result<Data, Error>) -> Void

    // MARK: - Public

    func createRequest(parameters: [String : String], url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.addValue(AppStaticConfig.myApiKey, forHTTPHeaderField: "x-apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }

    func makeRequest<T: Decodable>(model: T.Type, url: String, completion: @escaping (T) -> Void)  {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.addValue(AppStaticConfig.myApiKey, forHTTPHeaderField: "x-apikey")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = try JSONResponse<T>().response(for: data)
                    DispatchQueue.main.async {
                        completion(decoder)
                        return
                    }
                } catch {
                    print(error)
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
