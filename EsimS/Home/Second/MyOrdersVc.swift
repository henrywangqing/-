//
//  MyOrdersVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/18.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MyOrdersVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    var orders = [Order]()

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单列表"
        
        refreshData()
    }
    func refreshData() {
        APITool.request(target: .orderListInquiry(pageNumber: 1, pageSize: 10), success: { (result) in
            
            print(result)
            
        }) { (error) in
            print(error)
        }
    }

    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 160
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: OrderCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderCell
        if cell == nil {
            cell = OrderCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell.order = orders[indexPath.row]
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    

}
