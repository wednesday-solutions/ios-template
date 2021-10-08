//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

struct Networking {
    
    private var currentNetworkRequest: URLSessionDataTask?
    
    init() {
        currentNetworkRequest = nil
    }
    
    @discardableResult
    private func genericURLSession<A>(url: URL?, decoder: @escaping (Data) -> A?, completion: @escaping (Result<A, NetworkingError>) -> Void) -> URLSessionDataTask? {
        guard let url = url else {
            completion(.failure(.urlcomponentError))
            return nil
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                if let urlError = error as? URLError {
                    completion(.failure(.urlError(urlError)))
                } else {
                    completion(.failure(.apiError(error!)))
                }
                return
            }
            guard let data = data else {
                completion(.failure(.noDataError))
                return
            }
            
            let model: A? = decoder(data)
            
            guard let modelExists = model else {
                completion(.failure(.jsonDecodingError))
                return
            }
            completion(.success(modelExists))
        }
        dataTask.resume()
        return dataTask
    }
    
    mutating func genericURLSession<A: Decodable>(url: URL?, completion: @escaping (Result<A, NetworkingError>) -> Void) {
        cancelCurrentRequest()
        let dataTask = genericURLSession(url: url) { (data) -> A? in
            return try? JSONDecoder().decode(A.self, from: data)
        } completion: { completion($0) }
        currentNetworkRequest = dataTask
    }
    
    private func cancelCurrentRequest() {
        if self.currentNetworkRequest?.state == .some(.running) {
            self.currentNetworkRequest?.cancel()
        }
    }    
}
