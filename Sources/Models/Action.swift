//
//  Action.swift
//  Pods
//
//  Created by John Morgan on 22/07/2016.
//
//

import Foundation

public class Action<Model> {
    
    var invocation: ((Model) throws -> Void)?
    
    public init() { }
    
    public func invoke(with model: Model, from function: String = #function, file: String = #file, in caller: AnyObject? = nil) {

        FlowErrorHandler.handle(action: { try invocation?(model) }) {
            
            let children = caller.flatMap { Mirror(reflecting: $0) }?.children.flatMap { $0 }
            let label = children?.first { ($0.value as? AnyObject) === (self as? AnyObject) }?.label
            return InvocationContext(model: model, file: file, function: function, label: label)
        }
    }
    
    public func invoking(with model: Model) throws {
        
        try invocation?(model)
    }
}
