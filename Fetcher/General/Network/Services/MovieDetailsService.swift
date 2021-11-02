//
//  MovieDetailsService.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation

class MovieDetailsService: BaseService {
    
    //MARK:- Network calls
    /// Search for a movie
    /// - Parameters:
    ///   - searchTerm: String - The term to search for
    ///   - completion: Result<ResultsVO, NetworkError>
    public func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsModel, NetworkError>) -> Void) {
        let urlString = String(format: Paths.movie_details.apiPath(), String(movieId), Constants.api_key.rawValue)
        
        //Create the url
        guard let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
                let url = URL(string: escapedString) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        makeRequest(request: request) { result in
            switch(result) {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let results =  try decoder.decode(MovieDetailsModel.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(NetworkError.parseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
