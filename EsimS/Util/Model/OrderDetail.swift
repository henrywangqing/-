//
//  OrderDetail.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/13.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
class OrderDetail: HandyJSON {
    
    var agent: String = ""
    var count: Int = 0
    var name: String = ""
    var price: Double = 0
    var sum: Double = 0
    
    required init() {}
}
