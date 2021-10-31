//
//  Coordinator.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//


import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start(initialViewController:Coordinated)
}

class Coordinator: NSObject, CoordinatorProtocol, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.backgroundColor = UIColor.white
        self.navigationController.navigationBar.isTranslucent = true
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func start(initialViewController:Coordinated) {
        navigationController.delegate = self
        initialViewController.coordinator = self
        navigationController.pushViewController(initialViewController, animated: true)
    }
    
}
