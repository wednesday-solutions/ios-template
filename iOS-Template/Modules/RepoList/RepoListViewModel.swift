//
//  RepoListViewModel.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import Foundation

final class RepoListViewModel {
    let user: String
    private (set) var repositories: [Repository] = []
    private var nextPage: Int = 1
    var gitReposAPI: GitReposAPIProtocol
    
    init(user: String) {
        self.user = user
        self.gitReposAPI = GitReposAPI()
    }
    
    func searchForUserRepositories(callback: @escaping Callback<Result<[Repository], NetworkingError>>) {
        self.nextPage = 1
        searchUserRepositories { (result) in
            callback(result)
        }
    }
    
    private func searchUserRepositories(callback: @escaping Callback<Result<[Repository], NetworkingError>>) {
        gitReposAPI.getRepos(of: user) { (result) in
            switch result {
            case .success(let repos):
                self.repositories += repos
                self.nextPage += 1
            case .failure(let error):
                // FIXME: Handle Error
                dump(error)
            }
            callback(result)
        }
    }
    
}
