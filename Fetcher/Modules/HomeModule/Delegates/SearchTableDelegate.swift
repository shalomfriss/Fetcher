//
//  SearchTableDelegate.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

class SearchTableDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    public weak var homeViewModel:HomeViewModelProtocol?
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let result = homeViewModel?.results.results?[indexPath.row] {
            if let movieId = result.id {
                NetworkManager.shared.fetchMovieDetails(movieId: movieId) { movieDetails in
                    print(movieDetails)
                }
            }
        }
    }
    
    //MARK: - Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel?.results.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        if let result = homeViewModel?.results.results?[indexPath.row] {
            cell.config(result: result)
        }
        
        return cell
    }
    
    
}
