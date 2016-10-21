//
//  Reaction.swift
//  Pods
//
//  Created by John Morgan on 27/09/2016.
//
//

import Foundation

public class Reaction<Model, ResultingStack: StackNode> {
    
    var invoke: (Model) throws -> ResultingStack
    
    var configure: ((ResultingStack.ViewController, ResultingStack, Model) -> Void)?
    
    init(invoke: @escaping (Model) throws -> ResultingStack) {
        
        self.invoke = invoke
    }
    
    convenience init<From: StackNode>(from: From, verified: Bool = true, via transition: @escaping (From, Model) throws -> ResultingStack) {
        
        self.init() { [weak from = from] model in
            
            // TODO: Verify from is top of stack?
            
            guard let from = from else { throw FlowError.unretainedStack }
            
            guard let owner = from.owner else { throw FlowError.ownerlessStack }
            
            if verified { try from.verify() }
            
            let resultingStack = try transition(from, model)
            
            owner.stack = resultingStack
            
            return resultingStack
        }
    }
    
    func run(model: Model) throws {
        
        let stack = try invoke(model)
        configure?(stack.viewController, stack, model)
    }
    
    public func configured(configure: @escaping (ResultingStack.ViewController, ResultingStack, Model) -> Void) -> Reaction {
        
        self.configure = configure
        return self
    }
}

extension Reaction {
    
    public func configured(configure: @escaping (ResultingStack.ViewController, ResultingStack) -> Void) -> Reaction {
        
        return configured { vc, stack, _ in configure(vc, stack) }
    }
}
