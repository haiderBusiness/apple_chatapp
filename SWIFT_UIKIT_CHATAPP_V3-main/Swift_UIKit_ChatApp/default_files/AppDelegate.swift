//
//  AppDelegate.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.5.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        let thirdPhoto = PhotoMessage(
//            photoUrl: "http://localhost/test-server-images/landscape_street.jpeg",
//            placeHolderUrl: "http://localhost/test-server-images/landscape_street_placeholder.jpeg",
//            photoSizeInPX: ImageSizeInPX(width: 608, height: 1136),
//            photoSizeInBytes: "1.2 KB"
//        )
//
//        let appName = DataStore.shared.appName
//        let diskPath = appName + "/chats/1111/images"
        
        
        
        
        
        
//        for i in 0...chatrooms.count {
//
//        }
        
        
        // Override point for customization after application launch.
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

