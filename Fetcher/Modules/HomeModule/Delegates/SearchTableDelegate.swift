//
//  SearchTableDelegate.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

class SearchTableDelegate: NSObject, UITableViewDataSource {
    public weak var homeViewModel:HomeViewModelProtocol?
    
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
