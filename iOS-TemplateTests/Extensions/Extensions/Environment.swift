//
//  Environment.swift
//  iOS-TemplateTests
//
//  Created by Viranchee on 02/04/21.
//

import Foundation
@testable import iOS_Template

extension Environment {
  static let mock: Self = .init(networking: NetworkingMock())
}
