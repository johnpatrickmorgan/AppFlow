//
//  PopToNode.swift
//  Pods
//
//  Created by John Morgan on 13/09/2016.
//
//

import Foundation

extension NavigationChildLink {
    
    internal func popToNode<Node: NavigationChild, Model>(_ resultingStack: Node, animated: Bool = true) -> Reaction<Model, Node> {
        
        // TODO: verify node is in navigation stack?
        
        return Reaction(from: self) { me, _ in
            
            me.navigator.popToViewController(resultingStack.viewController, animated: animated)
            
            me.navigator.delegate = (resultingStack as? BackNavigationOverriding)?.declarativeNavigationDelegate
            
            return resultingStack
        }
    }
}
