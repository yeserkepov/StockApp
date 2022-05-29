//
//  AppDelegate.swift
//  HalykStocks
//
//  Created by Даурен on 24.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ModuleBuilder.shared.tabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

