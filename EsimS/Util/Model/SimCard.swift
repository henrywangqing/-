//
//  SimCard.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import HandyJSON
class SimCard: HandyJSON {
    
    var id: Int = 0
    var price: Double = 0
    var flow: Double = 0
    var discount: Double = 0
    var expire_date: String!
    var charge_expire_date: String!
    var imsi: String = ""
     
    required init() {}
}
