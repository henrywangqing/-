//
//  ErrorManager.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation

func manageError(code: Int, message: String) {
    if code == 402 {
        let alert = UIAlertController(style: .alert, title: Mystring(message), titleA: Mystring("确定"), colorA: UIColor.red, handlerA: { (action) in
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginVc())
        })
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }else {
        
        ProgressHUD.showError(withStatus: Mystring(message))
    }
}
