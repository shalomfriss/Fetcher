//
//  Coordinated.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

protocol Coordinated: UIViewController {
    var coordinator:CoordinatorProtocol? { get set }
}
