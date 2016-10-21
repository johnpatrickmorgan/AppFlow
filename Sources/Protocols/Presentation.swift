//
//  Presenting.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public protocol Presenting: StackNode { }

public protocol Dismissable: StackNodeLink {
    
    associatedtype PresentedViewController: UIViewController
    associatedtype PresentingStack: Presenting
    
    var lastPresented: Presented<PresentedViewController, PresentingStack> { get }
}

public extension Dismissable {
    
    var presenter: PresentingStack {
        return lastPresented.previous
    }
}
