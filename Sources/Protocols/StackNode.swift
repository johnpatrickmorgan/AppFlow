//
//  StackNode.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public protocol UntypedStackNode: class {
    
    var flow: UntypedFlow? { get set }
    
    var pictographicDescription: String { get }
    
    func verify() throws
    
    func verifyNonCircular(ancestors: [UntypedStackNode]) throws -> UntypedStackNode
}

public protocol StackNode: UntypedStackNode {
    
    associatedtype ViewController: UIViewController
    
    associatedtype RootViewController: UIViewController
    
    var viewController: ViewController { get }
    
    var rootViewController: RootViewController { get }
}

public protocol StackNodeEnd: StackNode {
    
    //    var previous: Void { get }
}

public protocol StackNodeLink: StackNode {
    
    associatedtype Previous: StackNode
    
    var previous: Previous { get }
    
    func _goBackToPrevious(animated: Bool)
}
