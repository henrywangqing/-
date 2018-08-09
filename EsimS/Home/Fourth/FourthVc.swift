//
//  FourthVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/1.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class FourthVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    
    let titleArr = ["账户ID","关于白马物联","版本"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Mystring("设置")
        
        setUpTableView()
       
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)! - (tabBarController?.tabBar.height)!), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 20
        tableView.estimatedSectionFooterHeight = 1
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titleArr.count
        }else {
            return 1
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = titleArr[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
 
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = DataManager.currentAccount().id
            }
            if indexPath.row != 2 {
                cell.accessoryType = .disclosureIndicator
            }else {
                let valueLbl = UILabel(frame: CGRect(x: KWidth - 220, y: 12, width: 200, height: 20), alignment: .right, fontsize: 17, text: Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)
                cell.contentView.addSubview(valueLbl)
                
            }

            return cell
        }else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = Mystring("退出登录")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
          
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                navigationController?.pushViewController(AccountVc(), animated: true)
            }else if indexPath.row == 1 {
                navigationController?.pushViewController(AboutVc(), animated: true)
            }
        }else {
            
            let alertController = UIAlertController(title: "确定退出登录吗", titleA: "取消", colorA: KBlueColor, handlerA: nil, titleB: "确定", colorB: UIColor.red) { [weak self] (action) in
              
                self!.logout()
            }
           
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func logoutRequest() {
        
        APITool.request(target: .logout(token: DataManager.currentAccount().token), success: { [weak self] (result) in
            print("退出", result)
            self!.logout()
        }) { (error) in
            print(error)
        }
    }
    func logout() {
        DataManager.destroyCurrentUserID()
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginVc())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
















