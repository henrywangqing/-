//
//  ForgetVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class ForgetVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Mystring("忘记密码")
        
        setUpTableView()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        tableView.estimatedSectionFooterHeight = 1
        view.addSubview(tableView)
        
    }

}
