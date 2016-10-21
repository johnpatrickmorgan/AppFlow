//
//  DismissTo.swift
//  Pods
//
//  Created by John Morgan on 16/09/2016.
//
//

import Foundation

extension Dismissable {
    
    public func dismissTo<Model>(_ _: Previous.ViewController.Type, animated: Bool = true) -> Reaction<Model, Previous> {
        
        return dismissToNode(previous, animated: animated)
    }
}

extension StackNodeLink where Previous: Dismissable {
    
    public func dismissTo<Model>(_ _: PrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return dismissToNode(prePrevious, animated: animated)
    }
    
    public func dismiss2<Model>(animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return dismissToNode(prePrevious, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: Dismissable {
    
    public func dismissTo<Model>(_ _: PrePrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return dismissToNode(prePrePrevious, animated: animated)
    }
    
    public func dismiss3<Model>(animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return dismissToNode(prePrePrevious, animated: animated)
    }
}
