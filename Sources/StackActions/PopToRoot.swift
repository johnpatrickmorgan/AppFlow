//
//  Pop+Ordinals.swift
//  Pods
//
//  Created by John Morgan on 13/09/2016.
//
//

import Foundation

extension NavigationChildLink where Previous: NavigationChildEnd {
    
    public func popToRoot<Model>(animated: Bool = true) -> Reaction<Model, Previous> {
        
        return pop(animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChildEnd {
    
    public func popToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return popToNode(prePrevious, animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChildLink, Previous.Previous.Previous: NavigationChildEnd {
    
    public func popToRoot<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return popToNode(prePrePrevious, animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChildLink, Previous.Previous.Previous: NavigationChildLink, Previous.Previous.Previous.Previous: NavigationChildEnd {
    
    public func popToRoot<Model>(animated: Bool) -> Reaction<Model, PrePrePrePrevious> {
        
        return popToNode(prePrePrePrevious, animated: animated)
    }
}
