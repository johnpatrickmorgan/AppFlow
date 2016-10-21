//
//  Dismiss.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

extension Dismissable {
    
    public func dismiss<Model>(animated: Bool = true) -> Reaction<Model, Previous> {
        
        return Reaction(from: self) { me, _ in
            
            me.previous.viewController.dismiss(animated: animated, completion: nil)
            
            return me.previous
        }
    }
}

extension ChildVCNode where ParentVCStack: Dismissable {
    
    public func dismiss<Model>(animated: Bool = true) -> Reaction<Model, ParentVCStack.PresentingStack> {
        
        return parentStack.lastPresented.dismiss(animated: animated)
    }
}
