//
//  Environment.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import Foundation
public enum Environment {
    enum Keys {
        enum Plist {
            static let serverUrl = "server_url"
            static let iTunesUrl = "itunes_base_url"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let serverUrl: URL = {
        guard let serverUrlString = Environment.infoDictionary[Keys.Plist.serverUrl] as? String else {
            fatalError("Server URL not set in plist for this environment")
        }
        guard let url = URL(string: serverUrlString) else {
            fatalError("Server URL is invalid")
        }
        return url
    }()
    
    // MARK: Itunes String
    static let iTunesUrl: String = {
        guard let iTunesUrlString = Environment.infoDictionary[Keys.Plist.iTunesUrl] as? String else {
            fatalError("Itunes URL not set in plist for this environment")
        }
        return iTunesUrlString
    }()
}
