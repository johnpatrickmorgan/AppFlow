//
//  UntypedFlow.swift
//  Pods
//
//  Created by John Morgan on 04/09/2016.
//
//

import Foundation

public protocol UntypedFlow: class {
    
    var stack: UntypedStackNode { get set }
    
    func stackDidChange()
}
