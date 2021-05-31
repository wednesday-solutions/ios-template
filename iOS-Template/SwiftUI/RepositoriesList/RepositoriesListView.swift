//
//  RepositoriesListView.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import SwiftUI

struct RepositoriesListView: View {
  
  private let user: GithubUser
  
  init(user: GithubUser) {
    self.user = user
  }
  
  var body: some View {
    Text(user.login)
  }
  
}

struct RepositoriesList_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesListView(user: .init(login: "User", id: 0))
  }
}
