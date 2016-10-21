//
//  StackNode+Owner.swift
//  Pods
//
//  Created by John Morgan on 05/09/2016.
//
//

import Foundation

extension StackNodeLink {
    
    public var owner: StackOwning? {
        get {
            return previous.owner
        }
        set {
            previous.owner = newValue
        }
    }
}
