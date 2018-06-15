//
//  UIColorExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/30.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
extension UIColor {
    
    class func createImageWithColor(_ color:UIColor) -> UIImage {
     
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
}

