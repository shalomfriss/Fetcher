//
//  HomeViewController.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation

import Foundation
import UIKit
import Combine

/// The products view controller
class HomeViewController: UIViewController, Coordinated {
    var coordinator: CoordinatorProtocol?
    var homeView: HomeView                  = HomeView()
    var homeViewModel:HomeViewModelProtocol?
    
    //MARK- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        homeViewModel?.bind(homeView: homeView)
    }
    
    override func loadView() { view = homeView }
    
}
