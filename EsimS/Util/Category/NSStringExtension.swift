//
//  StringExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/12.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

extension NSString {
 
    class func arrayFromString(_ string: String) -> [String] {
       
        if string.contains(",") {
            return string.components(separatedBy: ",")
        }else if string.contains(";") {
            
            return string.components(separatedBy: ";")
        }else if string.contains(" ") {
            return string.components(separatedBy: " ")
        }else {
            return [string]
        }
    }
    
    class func yyyyMMddFromString(_ string: String) -> String {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyyMMdd"
//        let date = dateFormatter.date(from: string)
//        if date == nil {
//            return "20000101"
//        }
//        return dateFormatter.string(from: date!)
        
        if string.count > 10 {
            
           return (string as NSString).substring(to: 10)
        }
        
        return "2000-01-01"
    }
}





