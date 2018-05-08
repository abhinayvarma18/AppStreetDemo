//
//  AppDelegate.swift
//  AppStreetDemo
//
//  Created by AbhinayVarma on 04/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.'
        loadInitialVC()
        return true
    }
    
    private func loadInitialVC() {
        let rootNewVc = ASMainViewController()
        let navigationController = UINavigationController(rootViewController: rootNewVc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.clear
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

