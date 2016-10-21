//
//  DismissToNode.swift
//  Pods
//
//  Created by John Morgan on 16/09/2016.
//
//

import Foundation

extension StackNodeLink {
    
    internal func dismissToNode<Node: StackNode, Model>(_ resultingStack: Node, animated: Bool = true) -> Reaction<Model, Node> {
        
        // TODO: verify node is in stack?
        
        return Reaction(from: self) { me, _ in
            
            resultingStack.viewController.dismiss(animated: animated)
            
            return resultingStack
        }
    }
}
