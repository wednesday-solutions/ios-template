//
//  ApolloClient.swift
//  BankShift
//
//  Created by Parth on 28/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation
import Apollo

// MARK: - Singleton Wrapper

class Network {
  static let shared = Network()
  
  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport: HTTPNetworkTransport = {
    let transport = HTTPNetworkTransport(url: URL(string: "https://pet-library.moonhighway.com")!)
//    transport.delegate = self
    return transport
  }()
    
  // Use the configured network transport in your Apollo client.
  private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}
