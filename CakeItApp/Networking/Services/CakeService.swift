//
//  CakeService.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import Combine

protocol CakeService: NetworkEngine {
    func getCakes() -> Future<[Cake], MyError>
}

extension CakeService {
    func getCakes() -> Future<[Cake], MyError> {
        let endpoint = Endpoint(scheme: Constants.Networking.scheme,
                                host: Constants.Networking.url,
                                path: Constants.Networking.path,
                                parameters: nil,
                                method: .get)
        
        return networkRequest(endpoint: endpoint)
    }
}
