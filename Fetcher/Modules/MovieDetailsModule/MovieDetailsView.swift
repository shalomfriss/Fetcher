//
//  MovieDetailsView.swift
//  Fetcher
//
//  Created by Shalom Friss on 11/2/21.
//

import Foundation
import UIKit

class MovieDetailsView:UIView {
    
    var tableView:UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        
        self.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.returnKeyType = .search
        tableView.tableHeaderView = searchController.searchBar
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        self.addSubview(activityIndicator)
        
    }
}
