//
//  DeclarativeNavigationDelegate.swift
//  Pods
//
//  Created by John Morgan on 09/09/2016.
//
//

import Foundation

class DeclarativeNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    var deferredDelegate: UINavigationControllerDelegate?
    
    var onWillShow: ((_ navigationController: UINavigationController, _ viewControllerToShow: UIViewController, _ animated: Bool) -> Void)?
    
    init(deferredDelegate: UINavigationControllerDelegate? = nil) {
        
        self.deferredDelegate = deferredDelegate
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewControllerToShow: UIViewController, animated: Bool) {
        
        onWillShow?(navigationController, viewControllerToShow, animated)
        
        deferredDelegate?.navigationController?(navigationController, willShow: viewControllerToShow, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        deferredDelegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }
    
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        
        return deferredDelegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) ?? navigationController.topViewController?.supportedInterfaceOrientations ?? [.allButUpsideDown]
    }
    
    public func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        
        return deferredDelegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) ?? navigationController.topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return deferredDelegate?.navigationController?(navigationController, interactionControllerFor: animationController)
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return deferredDelegate?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }
}
