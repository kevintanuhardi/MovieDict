//
//  SceneDelegate.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 03/07/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var homeNavigationController: UINavigationController!
    var searchNavigationController: UINavigationController!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBarController = UITabBarController()
        let homeVC = HomeViewController()
        let searchVC = SearchVC()
        homeNavigationController = UINavigationController.init(rootViewController: homeVC)
        searchNavigationController = UINavigationController.init(rootViewController: searchVC)
        tabBarController.viewControllers = [homeNavigationController, searchNavigationController]
        
        let homeItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        let searchItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        homeNavigationController.tabBarItem = homeItem
        searchNavigationController.tabBarItem = searchItem
        
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        UITabBar.appearance().barStyle = UIBarStyle.black
        UITabBar.appearance().backgroundColor = UIColor(red: 32/255.0, green: 33/255.0, blue: 35/255.0, alpha: 1.0)
        
        
        let viewController = tabBarController // Handle Develop Here
        let navigationBar = UINavigationController(rootViewController: viewController)
        navigationBar.isNavigationBarHidden = true
        window?.rootViewController = navigationBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

