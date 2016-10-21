//
//  FlowErrorHandler.swift
//  Pods
//
//  Created by John Morgan on 21/10/2016.
//
//

import Foundation

enum FlowErrorHandler {

    public static func printError(error: Error, context: InvocationContext?) {
        
        let contextLocation = [context?.function, context?.file].flatMap { $0 }.joined(separator: " ")
        
        print("FLOW ERROR: \(error) when invoking \(context?.label ?? "action") \(contextLocation)")
    }
    
    public static var errorHandler: (Error, InvocationContext?) -> Void = printError
    
    static func handle(action: () throws -> Void, context getContext: (() -> InvocationContext)? = nil) {
        
        do {
            try action()
        } catch {
            errorHandler(error, getContext?())
        }
    }
}
