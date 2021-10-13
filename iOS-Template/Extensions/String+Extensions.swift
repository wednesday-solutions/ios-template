//
//  String+Extension.swift
//  iOS-Template
//
//  Created by Apple on 13/10/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
