//
//  Pushed.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public class Pushed<ViewController: UIViewController, Previous: NavigationChild>: NavigationChildLink, BackNavigationOverriding {
    
    public var viewController: ViewController
    
    public var previous: Previous
    
    public var navigator: Previous.Navigator {
        return previous.navigator
    }
    
    public var parentStack: Previous.ParentVCStack {
        return previous.parentStack
    }
    
    public var navigationDelegate: UINavigationControllerDelegate? {
        return previous.navigationDelegate
    }
    
    var declarativeNavigationDelegate = DeclarativeNavigationDelegate()
    
    init(viewController: ViewController, previous: Previous) {
        
        self.viewController = viewController
        self.previous = previous
        
        let declarativeNavigationDelegate = DeclarativeNavigationDelegate()

        self.declarativeNavigationDelegate = declarativeNavigationDelegate
        
        declarativeNavigationDelegate.onWillShow = { [weak self] _, viewController, _ in
            
            guard let me = self else { return }
            
            if viewController === me.previous.viewController {
                
                FlowErrorHandler.handle(action: { try me._pop(performPop: false, animated: true).run(model: ()) })
            }
        }
        declarativeNavigationDelegate.deferredDelegate = navigationDelegate
        
        navigator.delegate = self.declarativeNavigationDelegate
    }
    
    public func verify() throws {
        
        try previous.verify()
        
        guard let myIndex = navigator.viewControllers.index(of: viewController) else {
            throw FlowError.unverifiableStack(message: "Expected \(viewController) to be among \(navigator)'s viewControllers, which are actually \(navigator.viewControllers)")
        }
        
        guard let previousIndex = navigator.viewControllers.index(of: previous.viewController) else {
            throw FlowError.unverifiableStack(message: "Expected \(previous.viewController) to be among \(navigator)'s viewControllers, which are actually \(navigator.viewControllers)")
        }
        
        guard myIndex == previousIndex + 1 else {
            throw FlowError.unverifiableStack(message: "Expected \(viewController) to be the successor of \(previous.viewController) in \(navigator)'s viewControllers, which are actually \(navigator.viewControllers)")
        }
    }
    
    public var pictographicDescription: String {
        return "\(previous.pictographicDescription) → \(ViewController.self)"  
    }
    
    public func _goBackToPrevious(animated: Bool) {
        
        navigator.popToViewController(previous.viewController, animated: animated)
        navigator.dismiss(animated: animated, completion: nil)
    }
}

protocol BackNavigationOverriding {
    
    var declarativeNavigationDelegate: DeclarativeNavigationDelegate { get }
}
