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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        
        let date = dateFormatter.date(from: string)
        if date == nil {
            return "2000-01-01"
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date!)
 
    }
    class func yyyyMMddHHmmssFromString(_ string: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        
        let date = dateFormatter.date(from: string)
        if date == nil {
            return "2000-01-01 00:00:00"
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date!)
        
    }
}





