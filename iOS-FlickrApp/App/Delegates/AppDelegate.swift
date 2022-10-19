//
//  AppDelegate.swift
//  iOS-FlickrApp
//
//  Created by Eray on 13.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        FirebaseApp.configure()
        
        _ = Firestore.firestore()
        
        return true
    }

    // MARK: - UISceneSession Lifecycle

    /*
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
     */
   

    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}

