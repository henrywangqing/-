//
//  PlanDetailVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/18.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class PlanDetailVc: BaseVc, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var plan: Plan!
    var bottomView: UIView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1 {
            return 80
        } else {
            return 160
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PlanDetailCell! 
        if indexPath.row == 0 {
            cell = PlanDetailCell(style: .default, reuseIdentifier: "First")
            
        } else if indexPath.row == 1 {
            cell = PlanDetailCell(style: .default, reuseIdentifier: "Second")
            
        } else {
            cell = PlanDetailCell(style: .default, reuseIdentifier: "Third")
           
        }
        cell.selectionStyle = .none
        cell.plan = plan
        
        return cell
    }
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!))
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = KBackgroundColor
        view.addSubview(tableView)
    }
    func setUpBottomView() {
        bottomView = UIView(frame: CGRect(x: 0, y: KHeight - KStatusBarH - (navigationController?.navigationBar.height)! - (tabBarController?.tabBar.height)!, width: KWidth, height: 49))
        bottomView.setShadow()
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        
        let hintLbl = UILabel(frame: CGRect(x: 20, y: 5, width: 300, height: 40))
        hintLbl.text = "最晚使用时间\n2018-08-27"
        hintLbl.numberOfLines = 0
        hintLbl.textColor = KColor(0, 0, 0, 0.6)
        hintLbl.font = UIFont.systemFont(ofSize: 13)
        bottomView.addSubview(hintLbl)
        
        let priceLbl = UILabel(frame: CGRect(x: KWidth - 200, y: 12, width: 100, height: 25))
        priceLbl.text = "24.64元"
        priceLbl.textColor = UIColor.red
        priceLbl.font = UIFont.systemFont(ofSize: 22)
        bottomView.addSubview(priceLbl)
        
        let buyBtn = UIButton(frame: CGRect(x: KWidth - 90, y: 0, width: 90, height: bottomView.height))
        buyBtn.backgroundColor = KOrangeColor
        buyBtn.setTitle("立即购买", for: .normal)
        buyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bottomView.addSubview(buyBtn)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Mystring("套餐详情")
        setUpTableView()
        setUpBottomView()
    }
}




