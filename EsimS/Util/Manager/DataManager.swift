//
//  DataManager.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/14.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation

let DirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last

let KCurrentUserID = "KCurrentUserID"

let CurrentAccountPath = path("CurrentAccount.plist")

let AccountsPath = path("Accounts.plist")

func path(_ pathName:String) -> String{
    return "\(DirPath ?? "")/\(pathName)"
}

class DataManager: NSObject {
    class func save(currentAccount: Account) {
        
        var accounts = DataManager.accounts()
        var isIn = false
        for i in 0 ..< accounts.count {
            if accounts[i].account == currentAccount.account {
                isIn = true
                accounts[i] = currentAccount
                accounts.swapAt(i, 0)
                break
            }
        }
        if isIn == false {
            accounts.append(currentAccount)
            accounts.swapAt(0, accounts.count - 1)
        }
        
        UserDefaults().set(currentAccount.account, forKey: KCurrentUserID)
        UserDefaults().synchronize()
        NSKeyedArchiver.archiveRootObject(currentAccount.toJSONString()!, toFile: CurrentAccountPath)
        
        NSKeyedArchiver.archiveRootObject(accounts.toJSONString()!, toFile: AccountsPath)
        
    }
    class func destroyCurrentUserID() {
        UserDefaults().set("", forKey: KCurrentUserID)
        UserDefaults().synchronize()
    }
     
    class func currentUserID() -> String {
        return UserDefaults().string(forKey: KCurrentUserID) ?? ""
    }
    
    class func currentAccount() -> Account {
        var account = Account()
        if let result = NSKeyedUnarchiver.unarchiveObject(withFile: CurrentAccountPath) as? String {
            account = Account.deserialize(from: result)!
        }
        
        return account
    }
    class func accounts() -> [Account] {
        var accounts = [Account]()
        
        if let jsonArrString = NSKeyedUnarchiver.unarchiveObject(withFile: AccountsPath) as? String,
           let result = [Account].deserialize(from: jsonArrString)! as? [Account]
            {
                accounts = result 
        }
        return accounts
    }
}





