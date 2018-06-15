//
//  Order.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/13.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
class Order: HandyJSON {
    
    var balance: Double = 0 
    var order_no: String = ""
    var order_type: String = ""
    var packageSumList: [OrderDetail]!
    
    required init() {}
}


