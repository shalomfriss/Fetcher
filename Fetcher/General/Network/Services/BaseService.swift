//
//  BaseService.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation

class BaseService {
    public func makeRequest(request:URLRequest, skipCache:Bool = false, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if(!skipCache) {
            if let cachedData = NetworkCache.shared.getCachedResponse(request: request) {
                completion(.success(cachedData))
                return
            }
        }
        
        let _ = URLSession.shared.dataTask(with: request) {(data, response, error) in
            //Check for an error
            if let error = error {
                completion(.failure(NetworkError.genericError(error: error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            if(response.statusCode < 200 || response.statusCode > 299) {
                completion(.failure(NetworkError.networkError(code: response.statusCode)))
            }
            
            guard let data = data else {
                if(response.statusCode == 204) {
                    completion(.success(Data()))
                } else {
                    completion(.failure(NetworkError.emptyData))
                }
                return
            }
            
            //Store response in cache
            let cachedData = CachedURLResponse(response: response, data: data)
            NetworkCache.shared.storeCachedResponse(cachedData, for: request)
            
            completion(.success(data))
        }.resume()
    }
}
