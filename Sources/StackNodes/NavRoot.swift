//
//  NavigationRoot.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public class NavRoot<ViewController: UIViewController, Previous: Presenting>: Presenting, NavigationChildEnd
             where Previous.ViewController: UINavigationController {
    
    public var viewController: ViewController
    
    public var previous: Previous
    
    public var navigator: Previous.ViewController {
        return previous.viewController
    }
    
    public var parentStack: Previous {
        return previous
    }
    
    public private(set) var navigationDelegate: UINavigationControllerDelegate?
    
    init(viewController: ViewController, previous: Previous, navigationDelegate: UINavigationControllerDelegate? = nil) {
        
        self.viewController = viewController
        self.previous = previous
        self.navigationDelegate = navigationDelegate
        
        navigator.delegate = navigationDelegate
    }
    
    public func verify() throws {
        
        try previous.verify()
        
        guard navigator.viewControllers.index(of: viewController) == 0 else {
            throw FlowError.unverifiableStack(message: "Expected \(viewController) to be first among \(navigator)'s viewControllers, which are actually \(navigator.viewControllers)")
        }
    }

    public var pictographicDescription: String {
        return "\(previous.pictographicDescription)\n\(ViewController.self)"
    }
    
    public func _goBackToPrevious(animated: Bool) {
        
        navigator.viewControllers = []
        navigator.dismiss(animated: animated, completion: nil)
    }
}
