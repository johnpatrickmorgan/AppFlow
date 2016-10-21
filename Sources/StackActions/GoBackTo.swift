//
//  UnwindTo.swift
//  Pods
//
//  Created by John Morgan on 30/09/2016.
//
//

import Foundation

extension StackNodeLink {
    
    public func goBackTo<Model>(_ _: Previous.ViewController.Type, animated: Bool = true) -> Reaction<Model, Previous> {
        
        return goBackToPreviousOf(self, animated: animated)
    }
    
    public func goBackTo<Model>(_ _: Previous.ViewController, animated: Bool = true) -> Reaction<Model, Previous> {
        
        return goBackToPreviousOf(self, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink {
    
    public func goBackTo<Model>(_ _: Previous.Previous.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return goBackToPreviousOf(previous, animated: animated)
    }
    
    public func goBackTo<Model>(_ _: Previous.Previous.ViewController, animated: Bool = true) -> Reaction<Model, PrePrevious> {
        
        return goBackToPreviousOf(previous, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink {
    
    public func goBackTo<Model>(_ _: PrePrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return goBackToPreviousOf(prePrevious, animated: animated)
    }
    
    public func goBackTo<Model>(_ _: PrePrePrevious.ViewController, animated: Bool = true) -> Reaction<Model, PrePrePrevious> {
        
        return goBackToPreviousOf(prePrevious, animated: animated)
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink, Previous.Previous.Previous: StackNodeLink {
    
    public func goBackTo<Model>(_ _: PrePrePrePrevious.ViewController.Type, animated: Bool = true) -> Reaction<Model, PrePrePrePrevious> {
        
        return goBackToPreviousOf(prePrePrevious, animated: animated)
    }
    
    public func goBackTo<Model>(_ _: PrePrePrePrevious.ViewController, animated: Bool = true) -> Reaction<Model, PrePrePrePrevious> {
        
        return goBackToPreviousOf(prePrePrevious, animated: animated)
    }
}
