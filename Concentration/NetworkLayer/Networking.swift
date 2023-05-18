//
//  Networking.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 10.05.2023.
//

import Foundation

enum NetworkError : Error {
    case invalidData
    case invalidUrl
}

struct Networking {
    
    typealias ModelCompletion = ((User?, Error?) -> Void)
    
    private func createRequests(url: String, httpMethod: String?,value: String?, header: String?) -> URLRequest? {
        guard let url = URL(string: url) else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod ?? "GET"
        request.setValue(value ?? "application/json; charset=utf-8",
                         forHTTPHeaderField: header ?? "Content-Type")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?)-> Void)?) {
        let sessinon = URLSession(configuration: .default)
        let dataTask = sessinon.dataTask(with: request) { data, response, error in
            guard let data = data else {
            completion?(nil, error)
                return
            }
            if let decodeResponse = try? JSONDecoder().decode(T.self,from: data) {
                DispatchQueue.main.async {
                    completion?(decodeResponse,nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
    
    public func fetchData(completion: ModelCompletion?){
        guard let request = createRequests(url: "get", httpMethod: nil, value: nil, header: nil) else { completion?(nil, NetworkError.invalidUrl )
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
