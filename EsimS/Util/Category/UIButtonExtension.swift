//
//  UIButtonExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/4.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(frame:CGRect, title:String = "", imageName:String = "", titleColor:UIColor = UIColor.black, backgroundColor:UIColor = UIColor.clear, fontsize:CGFloat = 15, target: Any?, selector: Selector?) {
        self.init(frame: frame)
        
        if imageName.count > 0 {
           self.setImage(UIImage(named: imageName), for: .normal)
        }
        if title.count > 0 {
            self.setTitle(title, for: .normal)
        }
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontsize)
        if target != nil {
            self.addTarget(target, action: selector!, for: .touchUpInside)
        }
    }
}







