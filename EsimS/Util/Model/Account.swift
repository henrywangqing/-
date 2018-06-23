//
//  Account.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//
import UIKit
import HandyJSON

struct Account: HandyJSON {
    var token: String = ""
    var account: String = ""
    var username: String = ""
    var created_at: String = ""
    var balance: Double = 0
    var comission: Double = 0
    var discount_cmcc: Double = 0
    var discount_ctcc: Double = 0
    var discount_cucc: Double = 0
    
    var description: [String: Any]{
        return self.toJSON()!
    }
}





