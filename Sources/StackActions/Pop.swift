//
//  Pop.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

extension NavigationChildLink {
    
    public func pop<Model>(animated: Bool = true) -> Reaction<Model, Previous>  {
        
        return _pop(performPop: true, animated: animated)
    }
    
    internal func _pop<Model>(performPop: Bool, animated: Bool) -> Reaction<Model, Previous> {
        
        return Reaction(from: self, verified: false) { me, _ in
            
            if performPop {
                try me.verify()
                me.navigator.popViewController(animated: animated)
            }
            
            me.navigator.delegate = (me.previous as? BackNavigationOverriding)?.declarativeNavigationDelegate
            
            return me.previous
        }
    }
}
