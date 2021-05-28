//
//  UserSelectionHandling.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import Foundation

protocol UserSelectionHandling: NSObject {
  
  func didSelect(user: GithubUser)
  
}
