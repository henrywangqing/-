//
//  FlowHistoryVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/25.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class FlowHistoryVc: BaseVc, UITableViewDataSource {
    var sim_no: String!
    var error = MyError()
    var tableView: UITableView!
    var flowList = FlowHistory()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Mystring("历史用量")
        
        getData()
        
        
 
    }
    func getData() {
        APITool.request(target: .inquiryHistoryUse(sim_no: "898604000118C0040300"), success: { [weak self] (result) in
            print("历史用量", result)
        }) { [weak self] (error) in
            print("历史用量错误", error)
            self!.error = error
            
        }
    }
    func setUpSubviews() {
        if error.code == 0 {
            
        }
    }
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 10, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!), style:.grouped)
        
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}






