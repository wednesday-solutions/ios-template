//
//  UsersListView.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import SwiftUI

struct UsersListView: View {
  
  @StateObject var viewModel = UsersListViewModel()
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Search")) {
          TextField("Username", text: $viewModel.searchText)
        }
        switch viewModel.users {
        case .success(let users) where users.isEmpty && viewModel.searchText.isEmpty:
          EmptyView()
        case .success(let users):
          Section(header: Text("\(users.count) Users Found")) {
            ForEach(users) { user in
              NavigationLink(destination: RepositoriesListView(user: user)) {
                Text(user.login)
              }
            }
          }
        case .failure(let error):
          Section(header: Text("Error")) {
            Text(error.localizedDescription)
          }
        }
      }
      .navigationTitle("Github User Search")
    }
  }
  
}

struct UsersListView_Previews: PreviewProvider {
  static var previews: some View {
    UsersListView()
  }
}
