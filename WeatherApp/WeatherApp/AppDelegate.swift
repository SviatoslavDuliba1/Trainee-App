//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 08.07.2022.
//

import UIKit

    @main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router = Router()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router.start(window: window)
        return true
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
