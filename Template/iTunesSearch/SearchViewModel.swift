//
//  SearchViewModel.swift
//  Template
//
//  Created by Rameez Khan on 23/10/21.
//

import Foundation
import UIKit
protocol ItunesApiServiceProtocol {
    func getSongs(for text: String, completion: @escaping (Result<ItunesSearchResult?, Error>) -> Void)
}

struct ItunesApiService: ItunesApiServiceProtocol {
    func getSongs(for text: String, completion: @escaping (Result<ItunesSearchResult?, Error>) -> Void) {
        let networkEngine = NetworkEngine(urlSession: URLSession.init(configuration: .default))
        let itunesEndpoint = ITunesEndpoint.getSong(searchText: text)
        networkEngine.request(endpoint: itunesEndpoint) { (itunesResult: Result<ItunesSearchResult?, Error>) in
           completion(itunesResult)
        }
    }
}

class SearchViewModel {
    let itunes: ItunesApiService
    var itunesResult = [ItunesResult]()
    var searchedText = ""
    var nsCache = NSCache<NSString, UIImage>()
    var reloadData: (() -> Void)?
    var passError: ((Error) -> Void)?
    init(with itunesService: ItunesApiService) {
        self.itunes = itunesService
    }
    
    func getSearchResult(_ searchText: String) {
        itunes.getSongs(for: searchText) { [weak self] (itunesResult) in
            switch(itunesResult) {
            case .failure(let error):
                print("error is \(error)")
                if let pass = self?.passError {
                    pass(error)
                }
            case .success(let searchResult):
                print("result is \(searchResult?.resultCount)")
                if let results = searchResult?.results, !results.isEmpty {
                    self?.itunesResult += results
                } else {
                    self?.itunesResult = []
                }
                if let reload = self?.reloadData {
                    reload()
                }
            }
        }
    }
}
