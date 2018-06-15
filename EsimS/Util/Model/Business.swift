//
//  Business.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/1.
//  Copyright © 2018年 iotwoods. All rights reserved.
//
 
import HandyJSON

struct Business: HandyJSON {
    var name: String = ""
    var total: Int = 0
    var inUse: Int = 0
    var outage: Int = 0
    var unknown: Int = 0
    var silent: Int = 0
    var test: Int = 0
    
    var description: [String: Any]{
        return self.toJSON()!
    }
}



