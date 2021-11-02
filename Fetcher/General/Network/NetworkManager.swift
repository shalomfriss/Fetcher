//
//  NetworkManager.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation

enum NetworkError: Error {
    case genericError(error:Error)
    case badURL
    case emptyResponse
    case emptyData
    case parseError
    case networkError(code:Int)
}

protocol NetworkManagerProtocol {
    func searchForMovie(searchTerm:String, completion: @escaping (Result<ResultsVO, NetworkError>) -> Void)
}


class NetworkManager: NetworkManagerProtocol {
   
    /// Shared class variable
    public static let shared:NetworkManager = NetworkManager()
    
    public var _movieSearchService = MovieSearchService()
    public var _movieDetailsService = MovieDetailsService()
    
    //MARK:- Network calls
    /// Search for a movie
    /// - Parameters:
    ///   - searchTerm: String - The term to search for
    ///   - completion: Result<ResultsVO, NetworkError>
    public func searchForMovie(searchTerm:String, completion: @escaping (Result<ResultsVO, NetworkError>) -> Void) {
        _movieSearchService.searchForMovie(searchTerm: searchTerm, completion: completion)
    }
    
    public func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsModel, NetworkError>) -> Void) {
        _movieDetailsService.fetchMovieDetails(movieId: movieId, completion: completion) 
    }
    
}
