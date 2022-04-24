//
//  NetworkEngine.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import Combine

protocol NetworkEngine {
    
    /// Generic Network Engine to make requests and parse responses into Codable class objects.
    /// Returns a Future object instead of using a Closure.
    /// - Returns: Future object with the data or an error.
    func networkRequest<T: Codable>(endpoint: Endpoint) -> Future<T, CakeAppError>
}

extension NetworkEngine {
    
    func networkRequest<T: Codable>(endpoint: Endpoint) -> Future<T, CakeAppError> {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters?.map({ row in return URLQueryItem(name: row.key, value: row.value) })
        
        guard let url = components.url else { return Future { promise in Result<T, CakeAppError>.failure(.NetworkEngineError) }}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        return Future() { promise in
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard response != nil else { return }
                guard let data = data else { return }
                guard let responseObject = try? JSONDecoder().decode(T.self, from: data) else { return }
                promise(.success(responseObject))
            }
            dataTask.resume()
        }
    }
}
