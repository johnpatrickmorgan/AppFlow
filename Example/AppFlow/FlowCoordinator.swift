//
//  FlowCoordinator.swift
//  Flow
//
//  Created by John Morgan on 09/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import AppFlow

struct FlowCoordinator {
    
    static func profileFlow(user: User) -> Flow<ProfileVC> {
        
        return Flow(root: ProfileVC(user: user)) { profileVC, stack in
            
            profileVC.editTapped ~~> stack.present { ProfileEditVC(user: $0) }.configured { profileEditVC, stack, user in

                profileEditVC.doneTapped ~~> stack.dismissToRoot()
            }
        }
    }
    
    let rootViewController = UITabBarController()
    
    let usersPFlow = Flow(root: UsersVC()) { usersVC, stack in
        
        usersVC.userSelected ~~> stack.present { ProfileVC() }.configured { profileVC, stack, user in
            
            profileVC.user = user
            profileVC.cancelTapped ~~> stack.dismiss()
            profileVC.editTapped ~~> stack.present { ProfileEditVC(user: $0) }.configured { profileEditVC, stack, user in
                
                profileEditVC.doneTapped ~~> stack.dismissTo(ProfileVC.self)
            }
        }
    }
    
    let usersNFlow = Flow(navigator: UINavigationController(), root: UsersVC()) { usersVC, stack in
        
        usersVC.userSelected ~~> stack.push { ProfileVC(user: $0) }.configured { profileVC, stack, user in
            
            profileVC.cancelTapped ~~> stack.pop()
            profileVC.editTapped ~~> stack.push { ProfileEditVC(user: $0) }.configured { profileEditVC, stack, user in
                
                profileEditVC.doneTapped ~~> stack.pop().configured { $0.user = $2 }
            }
        }
    }
    
    let usersNPFlow = Flow(navigator: UINavigationController(), root: UsersVC()) { usersVC, stack in
        
        usersVC.userSelected ~~> stack.push { ProfileVC(user: $0) }.configured { profileVC, stack in
            
            profileVC.cancelTapped ~~> stack.pop()
            profileVC.editTapped ~~> stack.present { ProfileEditVC(user: $0) }.configured { profileEditVC, stack, user in
                
                profileEditVC.doneTapped ~~> stack.goBackTo(UsersVC.self)
            }
        }
    }

    let usersPNFlow = Flow(root: UsersVC()) { usersVC, stack in
    
        usersVC.userSelected ~~> stack.presentNavigator(navigator: UINavigationController()) { ProfileVC(user: $0) }.configured { profileVC, stack, user in
            
            profileVC.cancelTapped ~~> stack.dismiss()
            profileVC.editTapped ~~> stack.push { ProfileEditVC(user: $0) }.configured { profileEditVC, stack, user in
                
                profileEditVC.doneTapped ~~> stack.pop().configured { $0.user = $2 }
            }
        }
    }
    
    let compositePFlow = Flow(root: UsersVC()) { usersVC, stack in
        
        usersVC.userSelected ~~> stack.presentFlow { FlowCoordinator.profileFlow(user: $0) }.configured { profileVC, stack, user in
            
            profileVC.cancelTapped ~~> stack.dismiss()
        }
    }

    let compositeNFlow = Flow(navigator: UINavigationController(), root: UsersVC()) { usersVC, stack in
        
        usersVC.userSelected ~~> stack.pushFlow { FlowCoordinator.profileFlow(user: $0) }.configured { profileVC, stack, user in
            
            profileVC.cancelTapped ~~> stack.pop()
        }
    }
    
    init() {
        
        usersPFlow.rootViewController.title = "P"
        usersNFlow.rootViewController.title = "N"
        usersNPFlow.rootViewController.title = "NP"
        usersPNFlow.rootViewController.title = "PN"
        compositePFlow.rootViewController.title = "CP"
        compositeNFlow.rootViewController.title = "CN"
        
        usersPFlow.onStackChange = { print($0.pictographicDescription) }
        usersNFlow.onStackChange = { print($0.pictographicDescription) }
        usersNPFlow.onStackChange = { print($0.pictographicDescription) }
        usersPNFlow.onStackChange = { print($0.pictographicDescription) }
        compositePFlow.onStackChange = { print($0.pictographicDescription) }
        compositeNFlow.onStackChange = { print($0.pictographicDescription) }
        
        // Non-flow approach for comparison:
        
        /*
        let usersVC = UsersVC()
        let nav = UINavigationController(rootViewController: UsersVC())
        usersVC.userSelected = { [unowned nav] user in
            
            let profileVC = ProfileVC(user: user)
            nav.pushViewController(profileVC, animated: true)
            
            profileVC.cancelTapped = { nav.popToRootViewController(animated: true) }
            profileVC.editTapped = { user in
                
                let profileEditVC = ProfileEditVC(user: user)
                nav.pushViewController(profileEditVC, animated: true)
                
                profileEditVC.cancelTapped = { nav.popToRootViewController(animated: true) }
                profileEditVC.doneTapped = { [weak profileVC] user in
                    
                    nav.popViewController(animated: true)
                    profileVC?.user = user
                }
            }
        }
        */
        
        rootViewController.viewControllers = [
            
            usersPFlow.rootViewController,
            usersNFlow.rootViewController,
            usersNPFlow.rootViewController,
            usersPNFlow.rootViewController,
            compositeNFlow.rootViewController
        ]
    }
}
