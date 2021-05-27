//
//  NetworkingError.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import Foundation

enum NetworkingError: Error {
  case urlcomponentError
  case apiError(Error)
  case urlError(URLError)
  case noDataError
  case jsonDecodingError
  case requestCancelled
}
