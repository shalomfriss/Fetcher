//
//  HomeViewModel.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit
import Combine

protocol HomeViewModelProtocol: NSObject {
    func bind(homeView:HomeView)
    var results:ResultsVO { get }
}

class HomeViewModel: NSObject, ObservableObject, HomeViewModelProtocol {
    private var cancellables: Set<AnyCancellable> = []
    @Published public var results: ResultsVO = ResultsVO(page: 0, totalResults: 0, totalPages: 0, results: [ResultVO]())
    private let _searchTableDelegate = SearchTableDelegate()
}

//MARK: - Setup
extension HomeViewModel{
    func bind(homeView: HomeView) {
        _searchTableDelegate.homeViewModel = self
        homeView.searchController.searchResultsUpdater = self
        homeView.searchController.searchBar.delegate = self
        homeView.tableView.dataSource = _searchTableDelegate
        homeView.tableView.delegate = _searchTableDelegate
        
        self.$results.receive(on: RunLoop.main).sink { results in
            homeView.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

//MARK: - Searching
extension HomeViewModel: UISearchResultsUpdating, UISearchBarDelegate {
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //Not responding to every button press
    }
    
    //UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchTerm = searchBar.text ?? ""
        NetworkManager.shared.searchForMovie(searchTerm: searchTerm) { [weak self] result in
            switch(result){
            case .success(let results):
                self?.results = results
            case .failure(let error):
                print(error)
            }
        }
    }
}


