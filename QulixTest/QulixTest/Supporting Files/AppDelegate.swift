//
//  AppDelegate.swift
//  QulixTest
//
//  Created by Павел Дубровский on 11/16/20.
//  Copyright © 2020 Павел Дубровский. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        buildWindow()
        return true
    }

    func buildWindow() {
        let searchController = SearchViewControllerBuilder().build()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = searchController
        window?.makeKeyAndVisible()
        
    }
}

