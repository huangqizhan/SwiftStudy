//
//  AppDelegate.swift
//  SwiftStudy
//
//  Created by hqz on 2019/7/12.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let tabbarVC = self.setupTableBarStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
        return true
    }
    func setupTableBarStyle(delegate:UITabBarControllerDelegate?) -> ESTabBarController {
        let tabbarController = ESTabBarController()
        tabbarController.delegate = delegate;
        tabbarController.title = "Irregularity"
        tabbarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabbarController.shouldHijackHandler = {
            tabbarController,ViewController,index in
            if index == 2{
                return true
            }else{
                return false
            }
        }
        
        tabbarController.didHijackHandler = {
            tabbarController,ViewController,index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                let warningView = MessageView.viewFromNib(layout: .cardView)
                warningView.configureTheme(.warning)
                warningView.configureDropShadow()
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!;
                warningView.configureContent(title: "Warning", body: "暂时没有此功能", iconText: iconText)
                warningView.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                SwiftMessages.show(config: warningConfig, view: warningView)
            })
        }
        
        let home = HHomeViewController()
        let listen = HListenViewController()
        let play = HListenViewController()
        let find = HFindViewController()
        let mine = HMineViewController()
        
        home.tabBarItem = ESTabBarItem.init(HIrregularityBasicContentView.init(), title: "首页", image: UIImage.init(named: "home"), selectedImage:  UIImage(named: "home_1"))
        
        listen.tabBarItem = ESTabBarItem.init(HIrregularityBasicContentView.init(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        play.tabBarItem = ESTabBarItem.init(HIrregularityContentView(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        
        find.tabBarItem = ESTabBarItem.init(HIrregularityBasicContentView.init(), title: "发现", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        
        mine.tabBarItem = ESTabBarItem.init(HIrregularityBasicContentView.init(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let homeNav = HBaseNavigationViewController.init(rootViewController: home)
        let listeNav = HBaseNavigationViewController.init(rootViewController: listen)
        let playNav = HBaseNavigationViewController.init(rootViewController: play)
        let findNav = HBaseNavigationViewController.init(rootViewController: find)
        let mineNav = HBaseNavigationViewController.init(rootViewController: mine)
        home.title = "首页"
        listen.title = "我听"
        play.title = "播放"
        find.title = "发现"
        mine.title = "我的"

        tabbarController.viewControllers = [homeNav,listeNav,playNav,findNav,mineNav]
        return tabbarController
        
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

