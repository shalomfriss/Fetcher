//
//  HomeView.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

class HomeView:UIView {
    
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


//extension HomeView: UISearchResultsUpdating, UISearchBarDelegate {
//    func updateSearchResults(for searchController: UISearchController) {
//        if(isFiltering) {
//            guard let filterText = searchController.searchBar.text else { return }
//            filterResults(filterText)
//        }
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if(isFiltering) {
//            return
//        }
//
//        self.activityIndicator.startAnimating()
//        guard let searchText = searchController.searchBar.text else { return }
//        searchController.searchBar.text = ""
//        self.presenter.searchForMovie(searchTerm: searchText, completion: { [weak self] results in
//                self?.activityIndicator.stopAnimating()
//                self?.searchTable.reloadData()
//        })
//    }
//
//    func filterResults(_ term:String) {
//        presenter.filterResults(for: term)
//        DispatchQueue.main.async {
//            self.searchTable.reloadData()
//        }
//    }
//
//}
//
