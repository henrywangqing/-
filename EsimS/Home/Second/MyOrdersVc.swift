//
//  MyOrdersVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/18.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MyOrdersVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    var ordersResult = OrdersResult()
    var tableView: UITableView!
    var page: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单列表"
        setUpTableView()
        refreshData(pageNumber: page)
    }
    
    func refreshData(pageNumber: Int) {
        if ordersResult.orderList.count >= ordersResult.totalPage {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        page += 1
        APITool.request(target: .orderListInquiry(pageNumber: page, pageSize: 10), success: { [weak self] (result) in
            if let resultDict = result as? NSDictionary,
                let ordersResult = OrdersResult.deserialize(from: resultDict) {
                print("订单列表", result)
                for order in ordersResult.orderList {
                    self!.ordersResult.orderList.append(order)
                }
                self!.tableView.reloadData() 
            }
            
            self!.tableView.mj_footer.endRefreshing() 
        }) { [weak self] (error) in
            print(error)
            self!.tableView.mj_footer.endRefreshing()
        }
    }

    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: view.height - KStatusBarH - (navigationController?.navigationBar.height)!), style: .grouped)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        tableView.rowHeight = 160
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 10
        tableView.estimatedSectionFooterHeight = 1
        tableView.separatorStyle = .none
    
        
        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {[weak self] in
            self!.refreshData(pageNumber: self!.page)
            
        })
        footer?.setTitle("加载中", for: .refreshing)
        footer?.setTitle(nil, for: .idle)
        footer?.activityIndicatorViewStyle = .gray
        tableView.mj_footer = footer
        view.addSubview(tableView)
        
    }
//    MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersResult.orderList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: OrderCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as? OrderCell
        if cell == nil {
            cell = OrderCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell.order = ordersResult.orderList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailVc()
        vc.order = ordersResult.orderList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
}
