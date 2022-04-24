//
//  ViewControllerInstantiator.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import UIKit

protocol ViewControllerInstantiator {
    
    
    /// Returns a new View Controller using the Storyboard and ViewController details.
    /// - Returns: View Controller.
    func newViewController(storyboard: Storyboard, viewController: ViewController) -> UIViewController
}

extension ViewControllerInstantiator {
    
    /// Default implementation for Protocol Oriented Programming
    func newViewController(storyboard: Storyboard, viewController: ViewController) -> UIViewController {
        return UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
            .instantiateViewController(identifier: viewController.rawValue)
    }
}
