//
//  Root.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public class Root<ViewController: UIViewController>: StackNodeEnd, Presenting {
    
    public var viewController: ViewController
    
    weak public var flow: UntypedFlow?
    
    public func configure(configure: (ViewController, Root) throws -> Void) rethrows -> Root {
        
        try configure(viewController, self)
        
        return self
    }
    
    public init(_ root: ViewController, flow: UntypedFlow? = nil, configure: ((ViewController, Root) -> Void)? = nil) {
        
        self.viewController = root
        self.flow = flow
        flow?.stack = self
        
        configure?(viewController, self)
    }
    
    public func verify() throws { }
    
    public var pictographicDescription: String {
        return "\(ViewController.self)"
    }
}
