//
//  PopTo.swift
//  Pods
//
//  Created by John Morgan on 13/09/2016.
//
//

import Foundation

extension NavigationChildLink where Previous: NavigationChild {
    
    public func popTo<Model>(_ _: Previous.ViewController.Type, animated: Bool = true) -> Reaction<Model, Previous> {
        
        return popToNode(previous, animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChild {
    
    public func popTo<Model>(_ _: PrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return popToNode(prePrevious, animated: animated)
    }
    
    public func pop2<Model>(animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return popToNode(prePrevious, animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChildLink, Previous.Previous.Previous: NavigationChild {
    
    public func popTo<Model>(_ _: PrePrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return popToNode(prePrePrevious, animated: animated)
    }
    
    public func pop3<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return popToNode(prePrePrevious, animated: animated)
    }
}

extension NavigationChildLink where Previous: NavigationChildLink, Previous.Previous: NavigationChildLink, Previous.Previous.Previous: NavigationChildLink, Previous.Previous.Previous.Previous: NavigationChild {
    
    public func popTo<Model>(_ _: PrePrePrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrePrePrevious> {
        
        return popToNode(prePrePrePrevious, animated: animated)
    }
    
    public func pop4<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrePrevious> {
        
        return popToNode(prePrePrePrevious, animated: animated)
    }
}
