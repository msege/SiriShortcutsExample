//
//  AppDelegate.swift
//  SiriShortcutsExample
//
//  Created by Sinan Ege on 3.10.2018.
//  Copyright © 2018 Sinan Ege. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let drinkActivityName = "com.sinanege.SiriExample.drinkCount"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        switch userActivity.activityType {
        case drinkActivityName:
            // You can define your action due to application logic
            guard let viewController = window?.rootViewController as? ViewController else {
                return false
            }
            
            // Check for drinkType which we passed while donating userActivity
            guard let drinkTypeRawValue = userActivity.userInfo?["drinkType"] as? String, let drinkType = DrinkType(rawValue: drinkTypeRawValue) else {
                return false
            }
            
            print("Drink activity for \(drinkType)")
            
            // Pass argument to viewController for increment counter
            viewController.didDrank(drinkType)
            
            return true
            
        default:
            return false
        }
    }
    
}

