//
//  HomeViewModel.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import Foundation

final class HomeViewModel {
  /// The network call that is happening in async currently
  var onDataLoad: (() -> Void)?
  private (set) var model: [GithubUser] = []
  private var searchString: String = ""
  private var nextPage = 1
  private var inFlightRequest: URLSessionDataTask?
  
  func searchStringChanged(newString: String) {
    self.searchString = newString
    self.nextPage = 1
    self.model = []
    self.onDataLoad?()
    makeNetworkCall()
  }
  
  func endOfPageReached() {
    makeNetworkCall()
  }
  
  private func makeNetworkCall() {
    if self.inFlightRequest?.state == .some(.running) {
      self.inFlightRequest?.cancel()
    }
    
    let dataTask = Networking().searchUsers(query: searchString, page: nextPage) { [weak self] (resultModel) in
      guard let self = self else { return }
      switch resultModel {
      case .success(let model):
        self.model += model.items
        self.nextPage += 1
        self.onDataLoad?()
      case .failure(let error):
        // FIXME: Handle Error
        dump(error)
      }
    }
    self.inFlightRequest = dataTask
  }

}
