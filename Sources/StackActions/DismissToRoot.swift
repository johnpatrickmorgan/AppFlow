//
//  DismissToRoot.swift
//  Pods
//
//  Created by John Morgan on 10/10/2016.
//
//

import Foundation

extension Dismissable where Previous: StackNodeEnd {
    
    public func dismissToRoot<Model>(animated: Bool = true) -> Reaction<Model, Previous> {
        
        return dismissToNode(previous, animated: animated)
    }
}

extension StackNodeLink where Previous: Dismissable, Previous.Previous: StackNodeEnd {
    
    public func dismissToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return dismissToNode(prePrevious, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: Dismissable, Previous.Previous.Previous: StackNodeEnd {
    
    public func dismissToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return dismissToNode(prePrePrevious, animated: animated)
    }
}
