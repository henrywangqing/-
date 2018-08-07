//
//  Account.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
// 
import HandyJSON

struct Account: HandyJSON {
    var token: String = ""
    var id: String = ""
    var username: String = ""
    var email: String = ""
    var mobile: String = ""
    
    var description: [String: Any]{
        return self.toJSON()!
    }
}





