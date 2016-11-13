//
//  StackNode+flow.swift
//  Pods
//
//  Created by John Morgan on 05/09/2016.
//
//

import Foundation

extension StackNodeLink {
    
    public var flow: UntypedFlow? {
        get {
            return previous.flow
        }
        set {
            previous.flow = newValue
        }
    }
}
