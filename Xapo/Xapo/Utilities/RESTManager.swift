//
//  WebServiceManager.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class RESTManager {
    
    // MARK: - Properties
    static let shared = RESTManager()
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Public API
    func hasInternetConnection() -> Bool {
        let reachability = Reachability()
        
        return reachability!.isReachable
    }
    
    func decodableRequest<T: Decodable>(from urlString: String, method: HttpMethod, parameters: [String: Any]?, completion: @escaping (T?) -> ()) {
        if hasInternetConnection() {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) else {
                
                fatalError("URL not formed")
            }
            
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let request = configureRequestFor(url, method: method, parameters: parameters)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    if let error = error {
                        completion(nil)
                        Logger.log(message: "Error \(String(describing: error))", type: .error)
                    }
                    
                    // Data acquired
                    do {
                        if let data = data {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            completion(object)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                        Logger.log(message: "Decoding error \(error.localizedDescription)", type: .error)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    // MARK: - Private API
    private func configureRequestFor(_ url: URL, method: HttpMethod, parameters: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            let query = (parameters.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            
            if let data = query.data(using: .utf8) {
                request.httpBody = data
            }
        }
        
        return request
    }
    
}
