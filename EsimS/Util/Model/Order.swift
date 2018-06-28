//
//  Order.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/27.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON

struct Order: HandyJSON {
    
    var charge_success: Bool = true
    var create_time: String = ""
    var expire_time: String = ""
    var fee: Double = 0
    var is_valid: Bool = true
    var month: Int = 0
    var order_id: Int = 0
    var order_no: String = ""
    var order_status: String = ""
    var order_type: String = ""
    var pay_status: String = ""
    var pay_type: String = ""
    var pay_time: String = ""
    var power_on: Bool = true
    var sum: Int = 0
}

struct OrdersResult: HandyJSON {
    var orderList = [Order]()
    var totalPage: Int = 1
}








