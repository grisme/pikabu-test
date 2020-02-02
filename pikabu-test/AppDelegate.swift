//
//  AppDelegate.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Private properties
    var coreWindow: UIWindow?
    
    // MARK: Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startUI()
        return true
    }
    
    // MARK: Private methods
    private func startUI() {
        coreWindow = UIWindow(frame: UIScreen.main.bounds)
        coreWindow?.rootViewController = buildFirstModule()
        coreWindow?.makeKeyAndVisible()
    }
    
    private func buildFirstModule() -> UIViewController {
        let postsListViewController = PostsListAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: postsListViewController)
        return navigationController
    }

}

