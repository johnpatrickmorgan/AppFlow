//
//  StackNode+Ordinals.swift
//  Pods
//
//  Created by John Morgan on 09/09/2016.
//
//

import Foundation

extension StackNodeEnd {
    
    var root: Self {
        
        return self
    }
    
    var first: Self {
        
        return root
    }
}

extension StackNodeLink where Previous: StackNodeEnd {
    
    var root: Previous {
        
        return previous
    }
    
    var first: Previous {
        
        return root
    }
    
    var second: Self {
        
        return self
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeEnd {
    
    var root: PrePrevious {
        
        return prePrevious
    }
    
    var first: Previous.Previous {
        
        return root
    }
    
    var second: Previous {
        
        return previous
    }
    
    var third: Self {
        
        return self
    }
}
