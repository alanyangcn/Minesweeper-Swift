//
//  AppDelegate.swift
//  Minesweeper
//
//  Created by 杨立鹏 on 2021/1/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: MenuViewController())
        
        self.window?.makeKeyAndVisible()
        return true
    }
}
