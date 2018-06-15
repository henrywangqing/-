//
//  CardManagementVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/6.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class CardManagementVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    
    let titleArr = ["白马号码","套餐名称","开始日期","结束日期","总流量(MB)","已使用(MB)","剩余流量(MB)"]
    
    var valueArr = ["234234","香港一日游","2018-03-08","2018-05-08","50","20.1","29.9"]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButton()
 
        setUpTableView()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? titleArr.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.textLabel?.text = titleArr[indexPath.row]
            cell.detailTextLabel?.text = valueArr[indexPath.row]
            
            return cell
        }else {
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.textLabel?.textColor = KBlueColor
            cell.textLabel?.text = "暂停卡"
            cell.textLabel?.textAlignment = .center
            
            return cell
        }
        
    }
    
    
    
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        
        view.addSubview(tableView)
        
    }
    func setBarButton() {
        title = "卡片管理"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc func dismissSelf() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
    }
}














