//
//  AppDelegate.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/23/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

///  This gets called when you run the simulator
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Will show the path to userDefaults
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    
        return true
    }
    
    /// If a user receives a call, the user can go back to the information they were adding on an app
    func applicationWillResignActive(_ application: UIApplication) {
        //
    }
    
    /// This is what happens when you close the app but not quitting the app, just goes into the backGround - going to the back of the stack
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App went into the background")
    }
    
    /// If a user quits the app and opens another app, it goes from being in the background to being terminated, so removed from memory
    func applicationWillTerminate(_ application: UIApplication) {
        print("AppQuit")
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
     
    }


}

