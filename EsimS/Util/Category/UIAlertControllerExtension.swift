//
//  UIAlertControllerExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/5.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

extension UIAlertController {
     
    convenience init(
        style:UIAlertControllerStyle = .alert, title:String = "", message:String = "",
        titleA:String = "", colorA:UIColor = UIColor.black, handlerA: ((UIAlertAction) -> Swift.Void)? = nil,
        titleB:String = "", colorB:UIColor = UIColor.black, handlerB: ((UIAlertAction) -> Swift.Void)? = nil
        ) {
        self.init(title: title, message: message, preferredStyle: style)
         
        if titleA.count > 0 {
            let actionA = UIAlertAction(title: titleA, style: .default, handler: handlerA)
            actionA.setValue(colorA, forKey: "_titleTextColor")
            self.addAction(actionA)
        }
        if titleB.count > 0 {
            let actionB = UIAlertAction(title: titleB, style: .default, handler: handlerB)
            actionB.setValue(colorB, forKey: "_titleTextColor")
            self.addAction(actionB)
        } 
    }
}









