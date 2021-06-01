//
//  Environment.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import Foundation

struct Environment {
  
  var networking: Endpoints
  
  init(networking: Endpoints) {
    self.networking = networking
  }
  
}

extension Environment {
  
  private static let live: Self = .init(networking: Networking())
  
  static var current: Self {
    #if DEBUG
    return .live
    #else
    return .live
    #endif
  }
  
}
