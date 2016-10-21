//
//  PushedStack.swift
//  Pods
//
//  Created by John Morgan on 15/09/2016.
//
//

import Foundation

public class PushedFlow<RootVC: UIViewController, Previous: NavigationChild>: Pushed<RootVC, Previous> {
    
    public var flow: Flow<RootVC>
    
    init(flow: Flow<RootVC>, previous: Previous) {
        
        self.flow = flow
        
        super.init(viewController: flow.rootViewController, previous: previous)
        
        flow.onStackChange = { [weak self] flow in
            guard let owner = self?.owner else { return }
            owner.stack = owner.stack
        }
    }
    
    public override func verify() throws {
        
        try super.verify()
        
        try flow.stack.verify()
    }
    
    public override var pictographicDescription: String {
        return "\(previous.pictographicDescription) → \(flow.stack.pictographicDescription)"
    }
}
