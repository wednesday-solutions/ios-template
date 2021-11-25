//
//  NetworkEngine.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

final class NetworkEngine {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T?, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        components.port = endpoint.port
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method
//        let urlString = "http://localhost:9999/itunes.apple.com/search?term=J&media=music"
//        let myReq = URLRequest(url: URL(string: urlString)!)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
        
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
