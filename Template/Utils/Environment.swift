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
          static let rootURL = "server_url"
          static let apiKey = "API_KEY"
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
      static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
          fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
          fatalError("Root URL is invalid")
        }
        return url
      }()

      static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
          fatalError("API Key not set in plist for this environment")
        }
        return apiKey
      }()
}
