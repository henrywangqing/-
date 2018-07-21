//
//  UIImageExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/4.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation

extension UIImage{
    
    /// 更改图片颜色
    func imageWithTintColor(color : UIColor) -> UIImage{
        UIGraphicsBeginImageContext(CGSize(width: self.size.width * 2, height: self.size.height * 2))
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width * 2, height: self.size.height * 2)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}


