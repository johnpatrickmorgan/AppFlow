//
//  _UIKitExtensions.swift
//  Pods
//
//  Created by John Morgan on 22/07/2016.
//
//

import Foundation

extension UIViewController {
    
    func presentationStack() -> [UIViewController] {
        
        return (self.presentingViewController?.presentationStack() ?? []) + [self]
    }
    
    func presentedStack() -> [UIViewController] {
        
        guard let presented = presentedViewController, !presented.isBeingDismissed else { return [self] }
        return [self] + presented.presentedStack()
    }
    
    public func dismissToViewController(_ to: UIViewController, animated: Bool, completion: (() -> Void)? = nil) -> [UIViewController]? {
        
        let stack = presentationStack()
        
        guard let index = (stack.enumerated().first { $0.1 === to || $0.1.childViewControllers.contains(to) }?.0) else { return nil }
        
        to.dismiss(animated: animated, completion: completion)
        
        return Array(stack.suffix(from: index).dropFirst())
    }
    
    public func dismissToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
        
        let stack = presentationStack()
        
        guard let first = stack.first else { return nil }
        
        first.dismiss(animated: animated, completion: nil)
        
        return Array(stack.dropFirst())
    }
}
