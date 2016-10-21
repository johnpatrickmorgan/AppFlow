//
//  AppDelegate.swift
//  Flow
//
//  Created by johnmorgan on 07/22/2016.
//  Copyright (c) 2016 johnmorgan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var flowCoordinator = FlowCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow()
        
        window.rootViewController = flowCoordinator.rootViewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
