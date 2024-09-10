//
//  AppDelegate.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
var AccentColor_yellow = UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)//黄色
var AccentColor_gray = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0)
//var AccentColor_gray = UIColor(red: 0/255, green: 53/255, blue: 102/255, alpha: 1)
//var AccentColor_gray = UIColor(red: 0x84 / 255.0, green: 0xC0 / 255.0, blue: 0x20 / 255.0, alpha: 1.0)




//let color1 = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)  // ffd60a
//let color2 = UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1)   // ffc300
//let color3 = UIColor(red: 0/255, green: 53/255, blue: 102/255, alpha: 1)    // 003566
//let color4 = UIColor(red: 0/255, green: 29/255, blue: 61/255, alpha: 1)     // 001d3d
//let color5 = UIColor(red: 0/255, green: 8/255, blue: 20/255, alpha: 1)      // 000814
