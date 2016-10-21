//
//  Navigation.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public protocol ChildVCNode: StackNodeLink {
    
    associatedtype ParentVCStack: Presenting
    
    var parentStack: ParentVCStack { get }
}

public protocol Pushing: Presenting {
    
    associatedtype Navigator: UINavigationController
    
    var navigator: Navigator { get }
    
    var navigationDelegate: UINavigationControllerDelegate? { get }
}

public typealias NavigationChild = Pushing & ChildVCNode

public protocol NavigationChildEnd: NavigationChild { }

public protocol NavigationChildLink: NavigationChild { }

