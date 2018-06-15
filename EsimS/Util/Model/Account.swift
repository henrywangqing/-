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
   
    var account: String = ""
    var addr:String = ""
    var companyBalance:CGFloat = 0
    var deleted:Int = 0
    var email:String = ""
    var id:Int = 0
    var mobile:String = ""
    var rolesString:String = ""
    var token:String = ""
    var username:String = ""
    var weichat:String = ""
    
  
    var description: [String: Any]{
        return self.toJSON()!
    }
    
}





