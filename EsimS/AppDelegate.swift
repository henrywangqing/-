//
//  AppDelegate.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/7.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setRootViewCottroller()
        ProgressHUD.setDefaultMaskType(.black)
        ProgressHUD.setMinimumDismissTimeInterval(1)
        ProgressHUD.setMaximumDismissTimeInterval(5)
        registerAPNS(application: application)
 
        return true
    }
    private func registerAPNS(application: UIApplication) {
        //请求通知权限
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
                (accepted, error) in
                if !accepted {
                    print("用户不允许消息通知。")
                }
        }
        
        //向APNs请求token
        application.registerForRemoteNotifications()
    }
    
    private func setRootViewCottroller() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible() 
        
        if DataManager.currentUserID().count > 0 {
            window?.rootViewController = MainTabBarVc()
        }else {
            window?.rootViewController = UINavigationController(rootViewController: LoginVc())
            
        }
        
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
        checkNetwork()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    MARK: 处理前台收到通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler([.sound,.alert])
    }
//    MARK: 处理后台点击通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler()
    }
//    MARK: 注册推送成功
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("device token： ", deviceToken.hexString)
    }
//    MARK: 注册推送失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("注册推送失败", error)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrder(withPaymentResult: url) { (dict) in
                print(dict!)
            }
        }
        
        return true
    }
 
}

