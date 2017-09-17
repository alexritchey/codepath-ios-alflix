//
//  AppDelegate.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/11/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // Override for Tab Bar
        // Reference a UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Reference to Main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        
        
        // Popular View
        let popularNavigationController = storyboard.instantiateViewController(withIdentifier:"GamesNavigationController") as! UINavigationController
        let popularViewController = popularNavigationController.topViewController as! GamesViewController
        popularViewController.endpoint = "?fields=name,popularity,summary,cover&order=popularity:desc"
        popularNavigationController.tabBarItem.title = "Popular"
        popularNavigationController.tabBarItem.image = UIImage(named: "gamepad")
        
        
        // Top Rated View
        let topRatedNavigationController = storyboard.instantiateViewController(withIdentifier: "GamesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! GamesViewController
        topRatedViewController.endpoint = "?fields=name,summary,cover&order=aggregated_rating:desc"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage(named: "star")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [popularNavigationController, topRatedNavigationController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

