//
//  UIKitExtensions.swift
//  Pods
//
//  Created by John Morgan on 22/07/2016.
//
//

import Foundation

public extension UIViewController {
    
    public func invoke<Model>(_ action: Action<Model>, with model: Model, from function: String = #function, file: String = #file) {
        
        action.invoke(with: model, from: function, file: file, in: self)
    }
    
    public func invoke(_ action: Action<Void>, from function: String = #function, file: String = #file) {
        
        action.invoke(with: (), from: function, file: file, in: self)
    }
}
