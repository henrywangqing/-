//
//  Order.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/13.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
struct Bill: HandyJSON {
    var month: Int = 0  
    var balance: Double = 0 
    var order_id: String = ""
    var order_no: String = ""
    var sumFee: Double = 0
    var order_type: String = ""
    var simList = [Int]()
    var packageSumList = [BillDetail]()
    
}
struct BillDetail: HandyJSON {
    
    var agent: String = ""
    var count: Int = 0
    var name: String = ""
    var price: Double = 0
    var sum: Double = 0
     
}




