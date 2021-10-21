//
//  ErrorTypes.swift
//  Template
//
//  Created by Rameez Khan on 21/10/21.
//

import Foundation

enum JSONError: Error {
    case decodeError
    case apiError
    var localisedDescription: String {
        switch self {
        case .apiError:
            return "There was a problem with the api"
        case .decodeError:
            return "There was a problem decoding data"
        }
    }
}
