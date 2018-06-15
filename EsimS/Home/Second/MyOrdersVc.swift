//
//  MyOrdersVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/18.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MyOrdersVc: BaseVc {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "订单列表"
    }

    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 48
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    

}
