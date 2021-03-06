//
//  SceneDelegate.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var handle:  AuthStateDidChangeListenerHandle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScence = scene as? UIWindowScene{
            let window = UIWindow(windowScene: windowScence)
            
            // detect whether this is the first fime launch this app
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
            if launchedBefore{
                // if launched before, then check if the user logged in
                handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
                    if user != nil{
                        print("already signed in")
                        
                        // save the uid for widget extension fetching the event details
                        let defaults = UserDefaults(suiteName: "group.sharingForVitalDaysWidgetExt")
                        defaults?.set(user!.uid, forKey: "uid")
                        
                        // present the main vc
                        let mainVC = ContainerViewController()
                        window.rootViewController = mainVC
                    }else{
                        
                        let signedInAnonymous = UserDefaults.standard.bool(forKey: "signedInAnonymous")
                        if signedInAnonymous{
                            let mainVC = ContainerViewController()
                            window.rootViewController = mainVC
                        }else{
                            let signInVC = LoginViewController()
                            window.rootViewController = signInVC
                        }
                    }
                })
            }else{
                // otherwise present the register page
                let registerVC = UIStoryboard(name: "RegisterViewControllerStoryboard", bundle: nil)
                let vc = registerVC.instantiateViewController(withIdentifier: "RegisterVC")
                window.rootViewController = vc
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                
                // sign out the Auth user
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("sign out failed...")
                }
            }
            
            // ask for notification permission
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound
                , .badge]) { (granted, err) in
                if granted{
                    print("permission granted")
                }else{
                    print("permission denied")
                }
            }
            
            weekday = ("\(year)-\(month)-\(day)".date?.firstDayOfTheMonth.weekday)!
            self.window = window
            window.makeKeyAndVisible()
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

