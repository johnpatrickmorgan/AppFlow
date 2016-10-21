//
//  StackNode+RootViewController.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

extension StackNodeEnd {
    
    public var rootViewController: ViewController { return viewController }
}

extension StackNodeLink {
    
    public var rootViewController: Previous.RootViewController { return previous.rootViewController }
}

extension StackNodeEnd {
    
    public func verifyNonCircular(ancestors: [UntypedStackNode] = []) throws -> UntypedStackNode {
        return self
    }
}

extension StackNodeLink {
    
    public func verifyNonCircular(ancestors: [UntypedStackNode] = []) throws -> UntypedStackNode {
        
        guard !ancestors.contains(where: { $0 === self }) else { throw FlowError.circularStack }
        
        return try previous.verifyNonCircular(ancestors: ancestors + [self])
    }
}
