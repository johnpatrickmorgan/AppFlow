//
//  StackNode+PrePrevious.swift
//  Pods
//
//  Created by John Morgan on 09/09/2016.
//
//

import Foundation

extension StackNodeLink where Previous: StackNodeLink {
    
    typealias PrePrevious = Previous.Previous
    
    var prePrevious: PrePrevious {
        
        return previous.previous
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink {
    
    typealias PrePrePrevious = Previous.Previous.Previous
    
    var prePrePrevious: PrePrePrevious {
        
        return previous.previous.previous
    }
}

extension StackNodeLink where Previous: StackNodeLink, Previous.Previous: StackNodeLink, Previous.Previous.Previous: StackNodeLink {
    
    typealias PrePrePrePrevious = Previous.Previous.Previous.Previous
    
    var prePrePrePrevious: PrePrePrePrevious {
        
        return previous.previous.previous.previous
    }
}
