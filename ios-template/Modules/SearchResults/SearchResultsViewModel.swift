//
//  SearchResultsViewModel.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import Foundation

class UsersViewModel {
  let searchText: String
  var userList: [GithubUser] = []
  
  init(searchText: String) {
    self.searchText = searchText
  }
  
  func searchUsers(closure: @escaping () -> Void ) {
    Networking().searchUsers(query: searchText) { (result) in
      switch result {
      case let .success(model):
        self.userList = model.items
      case let .failure(error):
        dump(error)
      }
      closure()
    }
  }
  
  func getNameFor(user atIndex: Int) -> String {
    return userList[atIndex].login
  }
}
