//
//  Card.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
struct CardsResult: HandyJSON {
    var totalCount: Int = 0
    var simList = [Card]()
    
}
struct ChargeCardsResult: HandyJSON {
    var totalPage: Int = 0
    var simList = [Int]()
    var chargeList = [Card]()
    var month: Int = 1
    
}

struct Card: HandyJSON {
     
    var order_no: String = ""
    var No: String = ""
    var contract_effect: Int = 0
    var id: Int = 0
    var iccid: String = ""
    var imsi: String = ""
    var msisdn: String = ""
    var supplier: String = ""
    var status: String = ""
    var query_time: String = "" // 最后一次查询时间
    var pkg_name: String = "" // 套餐名称
    var flow: Double = 0 // 套餐流量，单位 MB
    var flow_used: Double = 0
    var flow_left: Double = 0
    var pkgStatus: String = "" // 套餐状态，null 表示没找到
    var mark: String = "" // 备注
    var real_expire: String = "" // 到期时间
    var expire_date: String = ""
    var charge_expire_date: String = ""
    var company: String = ""
    var agent: String = ""
    var status_info: String = ""
    var open_time: String = ""
    var price: Double = 0
    var discount: Double = 0
    var bema_no: String = ""
    
}






