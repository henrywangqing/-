//
//  NetworkManager.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/29.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Alamofire
 
func checkNetwork() {
    
    let manger = NetworkReachabilityManager.init(host: "https://www.baidu.com")
    if manger!.isReachable == false {
        showNetworkOffAlert()
    }
}

private func showNetworkOffAlert() {
    let alert = UIAlertController(style: .alert, title: "\"白马物联\"的数据流量或蜂窝移动网络已关闭", message: "请在设置中为\"白马物联\"开启数据流量或蜂窝移动网络", titleA: "设置", colorA: KBlueColor, handlerA: { (action) in
        UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [String: String](), completionHandler: nil)
    }, titleB: "确定", colorB: UIColor.black, handlerB: nil)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
}







