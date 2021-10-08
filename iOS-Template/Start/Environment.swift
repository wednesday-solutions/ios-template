//
//  Environment.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import Foundation

struct Environment {
  var networking: Networking
}

extension Environment {
  static let live: Self = .init(networking: Networking())
}
