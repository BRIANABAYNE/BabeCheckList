//
//  AppDelegate.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/23/24.
//

import UIKit
import CoreData

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
        self.saveContext()
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
     
    }
    
    // MARK: - CoreData
    
    /// Global variable called, persistentContainer
    /// Lazy - only gets loaded at the time point as when it's needed - lazy get's a memory benefit
    /// NSPersistentContainer = SQLite database
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
      
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    
    
    
    

}

