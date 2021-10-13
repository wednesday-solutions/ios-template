//
//  Environment.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import Foundation

struct Environment {
    var networking: Endpoints
    
    static var baseURL: URL = {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError("Info.plist does not contail data with key BaseURL")
        }
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("invalid base URL format")
        }
        print("Base URL generated from build settings: \(baseURL.absoluteString)")
        return baseURL
    }()
}

extension Environment {
    static let live: Self = .init(networking: Networking())
}
