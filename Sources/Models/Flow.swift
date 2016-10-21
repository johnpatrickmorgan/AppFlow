//
//  Flow.swift
//  Pods
//
//  Created by John Morgan on 02/09/2016.
//
//

import Foundation

public class Flow<RootVC: UIViewController>: StackOwning {
    
    public var stack: UntypedStackNode {
        didSet {
            stack.owner = self
            FlowErrorHandler.handle(action: { try verifyRoot() })
            onStackChange?(self)
        }
    }
    
    public var onStackChange: ((Flow) -> Void)?
    
    public var rootStack: Root<RootVC>
    
    public var rootViewController: RootVC {
        return rootStack.viewController
    }
    
    init<RootNode: Root<RootVC>>(stack: RootNode) {
        
        self.rootStack = stack
        self.stack = stack
        self.stack.owner = self
    }
    
    func verifyRoot() throws {
        
        let root = try stack.verifyNonCircular(ancestors: [])
        guard rootStack === root else {
            throw FlowError.circularStack
        }
    }
}

extension Flow {
    
    public static func with<RootVC: UIViewController>(root: RootVC, configure: ((RootVC, Root<RootVC>) -> Void)? = nil) -> Flow<RootVC> {
        
        return Flow<RootVC>(root: root, configure: configure)
    }
    
    public convenience init(root: RootVC, configure: ((RootVC, Root<RootVC>) -> Void)? = nil) {
        
        let stack = Root<RootVC>(root, configure: configure)
        
        self.init(stack: stack)
    }
}

extension Flow {
    
    public var pictographicDescription: String {
        return "\n-----\(self)-----\n\(stack.pictographicDescription)"
    }
}

extension Flow where RootVC: UINavigationController {
    
    public convenience init<VC: UIViewController>(navigator: RootVC, root: VC, navigationDelegate: UINavigationControllerDelegate? = nil, configure: ((VC, NavRoot<VC, Root<RootVC>>) -> Void)? = nil) {
        
        navigator.viewControllers = [root]
        
        let previous = Root<RootVC>(navigator)
        
        let stack = NavRoot<VC, Root<RootVC>>(viewController: root, previous: previous, navigationDelegate: navigationDelegate)
        
        configure?(root, stack)
        
        self.init(stack: previous)
        self.stack = stack
    }
}
