//
//  MainTabBarVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MainTabBarVc: UITabBarController {
    let names = ["总览", "服务", "设置"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChildVcs()
 
    }
    private func settings() {
        tabBar.isTranslucent = false
    }
    
    private func setChildVcs() {
        let nav1 = UINavigationController(rootViewController: FirstVc())
        
        addChildViewController(nav1)
        let nav2 = UINavigationController(rootViewController: SecondVc())
        addChildViewController(nav2)
//        let nav3 = UINavigationController(rootViewController: ThirdVc())
//        addChildViewController(nav3)
        let nav4 = UINavigationController(rootViewController: FourthVc())
        addChildViewController(nav4)
        viewControllers = [nav1, nav2, nav4]
      
        for i in 0..<viewControllers!.count {
            if let vc = viewControllers![i] as? UINavigationController {
                vc.title = names[i]
                vc.tabBarItem.image = UIImage(named: names[i])
                vc.tabBarItem.selectedImage = UIImage(named: names[i])
                vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: KBlueColor], for: .selected)
                
            }
        }
        UITabBar.appearance().tintColor = KBlueColor
        UINavigationBar.appearance().tintColor = KBlueColor
    }
}




