//
//  RepositoriesListView.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import SwiftUI

struct RepositoriesListView: View {
  
  @StateObject var viewModel: RepositoriesListViewModel
  private let username: String
  
  init(user: GithubUser) {
    _viewModel = StateObject(wrappedValue: RepositoriesListViewModel(user: user))
    username = user.login
  }
  
  var body: some View {
    List {
      switch viewModel.repositories {
      case .success(let repositories):
        ForEach(repositories) { repository in
          Text(repository.name)
        }
      case .failure(let error):
        Text(error.localizedDescription)
      }
    }
    .navigationTitle(username)
  }
  
}

struct RepositoriesList_Previews: PreviewProvider {
  static var previews: some View {
    RepositoriesListView(user: .init(login: "User", id: 0))
  }
}
