//
//  UnwindToRoot.swift
//  Pods
//
//  Created by John Morgan on 04/10/2016.
//
//

import Foundation

extension StackNodeLink where Previous: StackNodeEnd {
    
    public func goBackToRoot<Model>(animated: Bool = true) -> Reaction<Model, Previous> {
        
        return goBackToPreviousOf(self, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeEnd {
    
    public func goBackToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return goBackToPreviousOf(previous, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink, Previous.Previous.Previous: StackNodeEnd {
    
    public func goBackToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return goBackToPreviousOf(prePrevious, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink, Previous.Previous.Previous: StackNodeLink, Previous.Previous.Previous.Previous: StackNodeEnd {
    
    public func goBackToRoot<Model>(animated: Bool) -> Reaction<Model, PrePrePrePrevious> {
        
        return goBackToPreviousOf(prePrePrevious, animated: animated)
    }
}
