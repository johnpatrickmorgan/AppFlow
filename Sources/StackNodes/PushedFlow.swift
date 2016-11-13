//
//  PushedStack.swift
//  Pods
//
//  Created by John Morgan on 15/09/2016.
//
//

import Foundation

public class PushedFlow<RootVC: UIViewController, Previous: NavigationChild>: Pushed<RootVC, Previous> {
    
    public var pushedFlow: Flow<RootVC>
    
    init(_ pushedFlow: Flow<RootVC>, previous: Previous) {
        
        self.pushedFlow = pushedFlow
        
        super.init(viewController: pushedFlow.rootViewController, previous: previous)
        
        pushedFlow.parentFlow = self.flow
    }
    
    public override func verify() throws {
        
        try super.verify()
        
        try pushedFlow.stack.verify()
    }
    
    public override var pictographicDescription: String {
        return "\(previous.pictographicDescription) → \(pushedFlow.stack.pictographicDescription)"
    }
}
