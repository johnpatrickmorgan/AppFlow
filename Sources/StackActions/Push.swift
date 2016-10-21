//
//  Push.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

extension Pushing where Self: ChildVCNode {
    
    public func push<Model, VC: UIViewController>(animated: Bool = true, vcFromModel: @escaping (Model) -> VC) -> Reaction<Model, Pushed<VC, Self>> {
        
        return Reaction(from: self) { me, model in
            
            let next = vcFromModel(model)
            
            me.navigator.pushViewController(next, animated: animated)
            
            let resultingStack = Pushed(viewController: next, previous: me)
            
            return resultingStack
        }
    }
    
    public func push<Model, VC: UIViewController>(animated: Bool = true, _ getViewController: @escaping () -> VC) -> Reaction<Model, Pushed<VC, Self>> {
        
        return push(animated: animated, vcFromModel: { _ in return getViewController() })
    }
}

extension Pushing where Self: ChildVCNode {
    
    public func pushFlow<Model, RootVC: UIViewController>(animated: Bool = true, flowFromModel: @escaping (Model) -> Flow<RootVC>) -> Reaction<Model, PushedFlow<RootVC, Self>> {
        
        return Reaction(from: self) { me, model in
            
            let nextFlow = flowFromModel(model)
            let nextViewController = nextFlow.rootViewController
            
            me.navigator.pushViewController(nextViewController, animated: animated)
            
            let resultingStack = PushedFlow(flow: nextFlow, previous: me)
            
            return resultingStack
        }
    }
    
    public func pushFlow<Model, RootVC: UIViewController>(animated: Bool = true, _ getFlow: @escaping () -> Flow<RootVC>) -> Reaction<Model, PushedFlow<RootVC, Self>> {
        
        return pushFlow(animated: animated, flowFromModel: { _ in getFlow() })
    }
}
