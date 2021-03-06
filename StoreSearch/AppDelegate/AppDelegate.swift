//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 30/07/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // MARK: - Properties
    var splitVC: UISplitViewController {
        return window!.rootViewController as! UISplitViewController
    }
    
    var searchVC: SearchViewController {
        return splitVC.viewControllers.first as! SearchViewController
    }
    
    var detailNavController: UINavigationController {
        return splitVC.viewControllers.last as! UINavigationController
    }
    
    var detailVC: DetailViewController {
        return detailNavController.topViewController as! DetailViewController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        
        searchVC.splitViewDetail = detailVC
        
        customizeAppearance()
        return true
    }

    // MARK: - Helper Methods
    func customizeAppearance() {
        let barTintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        UISearchBar.appearance().barTintColor = barTintColor
        window!.tintColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
        
        // For setting white background for searchbar textfield in case of ios13 OS
        if #available(iOS 13.0, *) {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            // UISearchBar.appearance().searchTextField.backgroundColor = UIColor.white
        }
    }
}

