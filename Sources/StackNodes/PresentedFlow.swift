//
//  PresentedFlow.swift
//  Pods
//
//  Created by John Morgan on 06/09/2016.
//
//

import Foundation

public class PresentedFlow<RootVC: UIViewController, Previous: Presenting>: Presented<RootVC, Previous> {
    
    
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
        return "\(previous.pictographicDescription)\n" +
               "↓\n" +
               "\(flow.stack.pictographicDescription)"
    }
}
