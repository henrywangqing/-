//
//  Define.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
 

let KStatusBarH = UIApplication.shared.statusBarFrame.height

let KBackgroundColor = KColor(239, 239, 244, 1)
let KOrangeColor = KColor(255, 105, 38, 1)
let KBlueColor = KColor(11, 106, 255, 1)
let KHeight = UIScreen.main.bounds.height
let KWidth = UIScreen.main.bounds.width

let AliPayAppID = "2018052260205188"
 
func randomColor() -> UIColor {
    return KColor(CGFloat(arc4random()%255),CGFloat(arc4random()%255), CGFloat(arc4random()%255), 1)
}

func KColor(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat, _ alpha:CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

func Mystring(_ name:String) -> String {
    return NSLocalizedString(name, comment: "")
}









