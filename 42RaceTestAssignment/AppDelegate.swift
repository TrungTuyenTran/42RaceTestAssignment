//
//  AppDelegate.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 16/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        openSearchViewController()
        return true
    }
    
    func openSearchViewController() {
        let vc = SearchViewController.initViewController(viewModel: SearchVM())
        let navVC = UINavigationController(rootViewController: vc)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
    
}

