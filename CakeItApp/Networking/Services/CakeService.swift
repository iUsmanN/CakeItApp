//
//  CakeService.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import Combine

protocol CakeService: NetworkEngine {
    
    /// Prepares and makes an API call to get Cakes.
    /// - Returns: Future object containing wither the cakes or an error.
    func getCakes() -> Future<[Cake], CakeAppError>
}

extension CakeService {
    
    /// Default implementation for Protocol Oriented Programming
    func getCakes() -> Future<[Cake], CakeAppError> {
        let endpoint = Endpoint(scheme: Constants.Networking.scheme,
                                host: Constants.Networking.url,
                                path: Constants.Networking.path,
                                parameters: nil,
                                method: .get)
        
        return networkRequest(endpoint: endpoint)
    }
}
