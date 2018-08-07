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
    
    class func yyyyMMddFromString(_ timeStamp: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        let date = Date.init(timeIntervalSince1970:  (Double(timeStamp) ?? 0) * 0.001)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
 
    }
    class func yyyyMMddHHmmssFromString(_ timeStamp: String) -> String {
        
        let dateFormatter = DateFormatter()
        let date = Date.init(timeIntervalSince1970: (Double(timeStamp) ?? 0) * 0.001)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
        
    }
}





