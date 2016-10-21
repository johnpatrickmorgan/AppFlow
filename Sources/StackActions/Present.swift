//
//  Present.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

extension Presenting {
    
    public func present<Model, VC: UIViewController>(animated: Bool = true, vcFromModel: @escaping (Model) -> VC) -> Reaction<Model, Presented<VC, Self>> {
        
        return Reaction(from: self) { me, model in
            
            let next = vcFromModel(model)
            
            me.viewController.present(next, animated: animated, completion: nil)
            
            return Presented(viewController: next, previous: me)
        }
    }
    
    public func present<Model, VC: UIViewController>(animated: Bool = true, getViewController: @escaping () -> VC) -> Reaction<Model, Presented<VC, Self>> {
        
        return present(animated: animated, vcFromModel: { _ in getViewController() })
    }
    
    public func presentNavigator<Model, Navigator: UINavigationController, VC: UIViewController>(
                        navigator getNavigator: @autoclosure @escaping () -> Navigator,
                        navigationDelegate: UINavigationControllerDelegate? = nil,
                        animated: Bool = true,
                        vcFromModel: @escaping (Model) -> VC) -> Reaction<Model, NavRoot<VC, Presented<Navigator, Self>>> {
        
        return Reaction(from: self) { me, model in
            
            let next = vcFromModel(model)
            let navigator = getNavigator()
            
            navigator.viewControllers = [next]
            me.viewController.present(navigator, animated: animated, completion: nil)
            
            let navigationStack = Presented(viewController: navigator, previous: me)
            let resultingStack = NavRoot(viewController: next, previous: navigationStack, navigationDelegate: navigationDelegate)
            
            return resultingStack
        }
    }
    
    public func presentNavigator<Model, Navigator: UINavigationController, VC: UIViewController>(
                        navigator getNavigator: @autoclosure @escaping () -> Navigator,
                        navigationDelegate: UINavigationControllerDelegate? = nil,
                        animated: Bool = true,
                        getViewController: @escaping () -> VC) -> Reaction<Model, NavRoot<VC, Presented<Navigator, Self>>> {
        
        return presentNavigator(navigator: getNavigator, navigationDelegate: navigationDelegate, animated: animated, vcFromModel: { _ in getViewController() })
    }
    
    public func presentFlow<Model, RootVC: UIViewController>(animated: Bool = true, flowFromModel: @escaping (Model) -> Flow<RootVC>) -> Reaction<Model, PresentedFlow<RootVC, Self>> {
        
        return Reaction(from: self) { me, model in
            
            let nextFlow = flowFromModel(model)
            let nextViewController = nextFlow.rootViewController
            
            me.viewController.present(nextViewController, animated: animated, completion: nil)
            
            let resultingStack = PresentedFlow(flow: nextFlow, previous: me)
            
            return resultingStack
        }
    }
    
    public func presentFlow<Model, RootVC: UIViewController>(animated: Bool = true, getFlow: @escaping () -> Flow<RootVC>) -> Reaction<Model, PresentedFlow<RootVC, Self>> {
        
        return presentFlow(animated: animated, flowFromModel: { _ in getFlow() })
    }
}
