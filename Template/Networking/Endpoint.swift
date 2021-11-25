//
//  Endpoint.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example itunes.apple.com
    var baseURL: String { get }
    
    // /search/
    var path: String { get }
    
    // search?term=taylor+swift
    var params: [URLQueryItem] { get }
    
    var method: String { get }
    
    var port: Int? { get }
}
