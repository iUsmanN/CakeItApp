//
//  Endpoint.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation

struct Endpoint {
    var scheme: String
    var host: String
    var path: String
    var parameters: [String:String]?
    var method: HTTPMethod
}

enum HTTPMethod : String {
    case get = "GET"
}
