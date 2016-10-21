//
//  FlowError.swift
//  Pods
//
//  Created by John Morgan on 22/07/2016.
//
//

import Foundation

public enum FlowError: Error, CustomStringConvertible {
    
    case unretainedStack
    case ownerlessStack
    case circularStack
    case unexpectedRoot(message: String)
    case unverifiableStack(message: String)
    
    public var description: String {
        
        switch self {
        case .unretainedStack:
            return "The flow stack was released unexpectedly"
        case .ownerlessStack:
            return "The flow stack has no owner"
        case .unverifiableStack(let message):
            return "The UIKit state does not match the flow stack: \(message)"
        case .circularStack:
            return "The flow stack contains a circular reference to one of its nodes"
        case .unexpectedRoot(let message):
            return "The flow stack's root was not as expected: \(message)"
        }
    }
}

public struct InvocationContext {
    
    let model: Any
    let file: String?
    let function: String?
    let label: String?
    
    init(model: Any, file: String? = nil, function: String? = nil, label: String? = nil) {
        
        self.model = model
        self.file = file
        self.function = function
        self.label = label
    }
}
