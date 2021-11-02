//
//  Paths.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation

/// Paths contains all the api paths in the app
enum Paths:String {
    //MARK: - API
    case base_path = "https://api.themoviedb.org/3/"
    case search         = "search/movie?api_key=%@&query=%@"
    case movie_details  = "movie/%@?api_key=%@"
    
    func apiPath() -> String {
        return "\(Paths.base_path.rawValue)\(self.rawValue)"
    }
    
    //MARK: - IMAGE
    case base_image_path = "https://image.tmdb.org/"
    case image = "t/p/w600_and_h900_bestv2%@"
    
    func imagePath() -> String {
        return "\(Paths.base_image_path.rawValue)\(self.rawValue)"
    }
}
