//
//  ErrorManager.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation

let KNetErrorCode = 999
let KFormatterErrorCode = 998
struct MyError {
    var code = 0
    var message = ""
}

func manageError(_ error: MyError) {
    if error.code == 402 {
        let alert = UIAlertController(style: .alert, title: Mystring(error.message), titleA: Mystring("确定"), colorA: UIColor.red, handlerA: { (action) in
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginVc())
        })
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }else {
        
        ProgressHUD.showError(withStatus: Mystring(error.message))
    }
}
