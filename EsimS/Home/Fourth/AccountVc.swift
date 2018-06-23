//
//  AccountVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/11.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class AccountVc: BaseVc, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账号"
 
        setUpTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)! - (tabBarController?.tabBar.height)!), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 20
        tableView.estimatedSectionFooterHeight = 1
        view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}






