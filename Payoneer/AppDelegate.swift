//
//  AppDelegate.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 11.05.21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        applicationCoordinator.start()
        
        return true
    }
}
