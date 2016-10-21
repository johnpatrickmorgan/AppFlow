//
//  FlowOperator.swift
//  Pods
//
//  Created by John Morgan on 22/07/2016.
//
//

import Foundation

precedencegroup AppFlowPrecedence { associativity: right }

infix operator ~~>: AppFlowPrecedence

public func ~~><Model>(action: inout Action<Model>, closure: @escaping (Model) throws -> Void) {
    
    action.invocation = closure
}

public func ~~><Model>(lhs: inout ((Model) -> Void)?, closure: @escaping (Model) throws -> Void) {
    
    lhs = { model in

        FlowErrorHandler.handle(action: { try closure(model) }) { InvocationContext(model: model) }
    }
}

public func ~~><Model, ResultingStack: StackNode>(action: inout Action<Model>, reaction: Reaction<Model, ResultingStack>) {
    
    action.invocation = reaction.run
}

public func ~~><Model, ResultingStack: StackNode>(lhs: inout ((Model) -> Void)?, reaction: Reaction<Model, ResultingStack>) {
    
    lhs = { model in
        
        FlowErrorHandler.handle(action: { try reaction.run(model: model) }) { InvocationContext(model: model) }
    }
}

public func ~~><Model>(closure1: @escaping (Model) throws -> Void, closure2: @escaping (Model) throws -> Void) -> (Model) throws -> Void {
    
    return { model in
        try closure1(model)
        try closure2(model)
    }
}
