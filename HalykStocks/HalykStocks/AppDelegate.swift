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
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let navigationVC = UINavigationController()
//        window?.rootViewController = navigationVC
//        navigationVC.pushViewController(StocksViewController(), animated: false)
//        window?.makeKeyAndVisible()
        
        return true
    }
}

