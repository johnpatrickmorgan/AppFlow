//
//  PresentedFlow.swift
//  Pods
//
//  Created by John Morgan on 06/09/2016.
//
//

import Foundation

public class PresentedFlow<RootVC: UIViewController, Previous: Presenting>: Presented<RootVC, Previous> {
    
    public var presentedFlow: Flow<RootVC>
    
    init(_ presentedFlow: Flow<RootVC>, previous: Previous) {
        
        self.presentedFlow = presentedFlow
        
        super.init(viewController: presentedFlow.rootViewController, previous: previous)
        
        presentedFlow.parentFlow = self.flow
    }
    
    public override func verify() throws {
        
        try super.verify()
        
        try presentedFlow.stack.verify()
    }
        
    public override var pictographicDescription: String {
        return "\(previous.pictographicDescription)\n" +
               "↓\n" +
               "\(presentedFlow.stack.pictographicDescription)"
    }
}
