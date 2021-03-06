//
//  HomeViewController.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit
import Combine

/// The products view controller
class HomeViewController: UIViewController, Coordinated {
    var coordinator: CoordinatorProtocol?
    var homeView: HomeView = HomeView()
    var homeViewModel: HomeViewModelProtocol?
    
    init(viewModel:HomeViewModelProtocol) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel?.bind(homeView: homeView)
    }
    
    override func loadView() { view = homeView }
    
}
