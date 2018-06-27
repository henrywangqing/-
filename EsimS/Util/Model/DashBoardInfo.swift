//
//  FirstPage.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/14.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
struct DashBoardInfo: HandyJSON {

    var baseInfo = BaseInfo()
    var discountList = [DiscountInfo]()
    var simInfoList = [SupplierTable]()
    var total: Int = 0
    
}

struct BaseInfo: HandyJSON {
    
    var account = ""
    var appkey = ""
    var balance: Double = 0
    var commission: Double = 0
    var create_time = ""
    
}
struct SupplierTable: HandyJSON {
    
    var s0: Int = 0
    var s1: Int = 0
    var s2: Int = 0
    var s3: Int = 0
    var s4: Int = 0
    var s5: Int = 0
    var count: Int = 0
    var name: String = ""
    var status_info = ""
    
}

struct DiscountInfo: HandyJSON {
    
    var discount: Double = 1
    var name = ""
     
}



