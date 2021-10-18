//
//  NetworkEngine.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

class NetworkEngine {
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
        
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    completion(.failure(JSONError.decodeError))
                }
            }
        }
        dataTask.resume()
    }
}

enum JSONError: Error {
    case decodeError
    
    var localisedDescription: String {
        switch self {
        case .decodeError:
            return "There was a problem decoding data"
        }
    }
}
