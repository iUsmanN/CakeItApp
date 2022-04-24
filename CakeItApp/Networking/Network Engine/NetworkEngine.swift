//
//  NetworkEngine.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import Combine

protocol NetworkEngine {
    func networkRequest<T: Codable>(endpoint: Endpoint) -> Future<T, MyError>
}

extension NetworkEngine {
    
    func networkRequest<T: Codable>(endpoint: Endpoint) -> Future<T, MyError> {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters?.map({ row in return URLQueryItem(name: row.key, value: row.value) })
        
        guard let url = components.url else { return Future { promise in Result<T, MyError>.failure(.NetworkEngineError) }}
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
