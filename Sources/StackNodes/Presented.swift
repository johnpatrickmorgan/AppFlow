//
//  Presented.swift
//  Pods
//
//  Created by John Morgan on 01/09/2016.
//
//

import Foundation
import UIKit

public class Presented<ViewController: UIViewController, Previous: Presenting>: Presenting, Dismissable {
    
    public var viewController: ViewController
    
    public var previous: Previous
    
    public var lastPresented: Presented { return self }
    
    init(viewController: ViewController, previous: Previous) {
        
        self.viewController = viewController
        self.previous = previous
    }
    
    public func verify() throws {
        
        try previous.verify()
        
        guard viewController == previous.viewController.presentedViewController else {
            throw FlowError.unverifiableStack(message: "Expected \(viewController) to be the presentedViewController of \(previous.viewController) whichis actually \(previous.viewController.presentedViewController)")
        }
    }
    
    public var pictographicDescription: String {
        return "\(previous.pictographicDescription)\n" +
               "↓\n" +
               "\(ViewController.self)"
    }
    
    public func _goBackToPrevious(animated: Bool) {
        
        previous.viewController.dismiss(animated: animated, completion: nil)
    }
}
