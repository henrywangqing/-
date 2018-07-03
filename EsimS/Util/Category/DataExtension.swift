//
//  DataExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation 
extension Data {
    //将Data转换为String
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
