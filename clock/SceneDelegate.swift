//
//  SceneDelegate.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/13.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarcontroller()
        window?.makeKeyAndVisible()
    }

    func creatWorldColockNV() -> UINavigationController {
        let worldClockVC = WorldClock()
        worldClockVC.title = "世界鬧鐘"
        worldClockVC.tabBarItem.image = UIImage(systemName: "globe")
        return UINavigationController(rootViewController: worldClockVC)
    }
    func creatAlarmNV() -> UINavigationController {
        let alarmVC = AlarmViewController()
        alarmVC.title = "鬧鐘"
        alarmVC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        return UINavigationController(rootViewController: alarmVC)
    }
    
    func creatStopWatchNV() -> UINavigationController {
        let stopWatchVC = TimerVC()
        stopWatchVC.title = "碼表"
        stopWatchVC.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        return UINavigationController(rootViewController: stopWatchVC)
    }
    
    func creatTimerNV() -> UINavigationController {
        let timerVC = TimerVC()
        timerVC.title = "計時器"
        timerVC.tabBarItem.image = UIImage(systemName: "timer")
        return UINavigationController(rootViewController: timerVC)
    }
    
    
    func createTabBarcontroller() -> UITabBarController {
        let tabbar = UITabBarController()
        tabbar.tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabbar.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabbar.tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        tabbar.viewControllers = [creatWorldColockNV(),creatAlarmNV(),creatStopWatchNV(),creatTimerNV()]
        return tabbar
    }
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

