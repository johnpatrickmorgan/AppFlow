//
//  UnwindToNode.swift
//  Pods
//
//  Created by John Morgan on 04/10/2016.
//
//

import Foundation

extension StackNodeLink {
    
    internal func goBackToPreviousOf<Node: StackNodeLink, Model>(_ node: Node, animated: Bool = true) -> Reaction<Model, Node.Previous> {
        
        // TODO: verify node is in stack?
        
        return Reaction(from: self) { me, _ in
            
            node._goBackToPrevious(animated: animated)
            
            return node.previous
        }
    }
}
