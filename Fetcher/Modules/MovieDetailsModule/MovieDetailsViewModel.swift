//
//  MovieDetailsViewModel.swift
//  Fetcher
//
//  Created by Shalom Friss on 11/2/21.
//

import Foundation
import UIKit
import Combine

protocol MovieDetailsViewModelProtocol: NSObject {
    func bind(movieDetailsView:MovieDetailsView)
    
}

class MovieDetailsViewModel: NSObject, ObservableObject, MovieDetailsViewModelProtocol {
    private var cancellables: Set<AnyCancellable> = []
    @Published public var results: ResultsVO = ResultsVO(page: 0, totalResults: 0, totalPages: 0, results: [ResultVO]())
}

//MARK: - Setup
extension MovieDetailsViewModel {
    func bind(movieDetailsView:MovieDetailsView) { 
        
//        self.$results.receive(on: RunLoop.main).sink { results in
//            homeView.tableView.reloadData()
//        }.store(in: &cancellables)
    }
}
