//
//  HomeViewModel.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import Foundation

class HomeViewModel {
  /// The network call that is happening in async currently
  var onDataLoad: (() -> Void)?
  private var searchString: String = ""
  private var nextPage = 1
  private (set) var model: [GithubUser] = []
  private var inFlightRequest: URLSessionDataTask?
  
  func searchStringChanged(newString: String) {
    // This removes unnecessary network request, unnecessary calls made by SearchBar when string is same
    print("New: \(newString), Old: \(searchString), Equal: \(newString == searchString)")
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
    switch self.inFlightRequest?.state {
    case .canceling:
      print("Cancelling")
    case .completed:
      print("Completed")
    case .running:
      self.inFlightRequest?.cancel()
      print("Running, now cancelled")
    case .suspended:
      print("Suspended")
    case .none:
      print("Removed, Optional NONE")
    default:
      print("New case")
    }
    
    let dataTask = Networking().searchUsers(query: searchString, page: nextPage) { [weak self] (resultModel) in
      guard let self = self else { return }
      switch resultModel {
      case .success(let model):
        self.model += model.items
        self.nextPage += 1
        self.onDataLoad?()
        print("Network ✅ items: \(self.model.count)")
      case .failure(let error):
        print("Network ❌ failed, items: \(self.model.count)")

        dump(error)
      }
    }
    self.inFlightRequest = dataTask
  }

}
