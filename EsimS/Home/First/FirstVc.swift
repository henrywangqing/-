//
//  FirstVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

import CryptoSwift
class FirstVc: BaseVc {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    var dashBoardInfo = DashBoardInfo()
    var titleArr = [String]()
    var valueArr = [String]()
    weak var apiLbl: UILabel!
    var scrollView = UIScrollView()
    var accountInfoView: UIView!
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (tabBarController?.tabBar.height)! - (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self!.refreshData()
            
        })
        view.addSubview(scrollView)
        setUpAccountInfoData()
        setUpAccountInfoView()
        setUpBusinessDiagramView()
    }
    //        MARK:数据
    func setUpAccountInfoData() {
        
        titleArr = ["账号名称","注册日期","账号余额",
                        "佣金余额","api key"]
        
        valueArr = ["\(dashBoardInfo.baseInfo.account)","\(NSString.yyyyMMddFromString(dashBoardInfo.baseInfo.create_time))","¥\(String(format: "%.2f", dashBoardInfo.baseInfo.balance))","¥\(String(format: "%.2f", dashBoardInfo.baseInfo.commission))", "\(dashBoardInfo.baseInfo.appkey)"]
        for i in 0 ..< dashBoardInfo.discountList.count {
            titleArr.insert("\(dashBoardInfo.discountList[i].name)套餐折扣", at: 3 + i)
            valueArr.insert("\(dashBoardInfo.discountList[i].discount)", at: 3 + i)
        }
    }
    
    func setUpBusinessDiagramView() {
        let headLbl = UILabel(frame: CGRect(x: 10, y: 10 + accountInfoView.frame.maxY, width: 300, height: 25))
        headLbl.font = UIFont.systemFont(ofSize: 18)
        headLbl.textColor = KColor(0, 0, 0, 0.8)
        headLbl.text = "运营报表"
        scrollView.addSubview(headLbl)
        
        let subheadLbl = UILabel(frame: CGRect(x: 10, y: 10 + headLbl.frame.maxY, width: 300, height: 25))
        subheadLbl.font = UIFont.systemFont(ofSize: 15)
        
        scrollView.addSubview(subheadLbl)
        
        
        for i in 0 ..< dashBoardInfo.simInfoList.count {
            let supplierTableView = SupplierTableView(frame: CGRect(x: 10, y: subheadLbl.frame.maxY + 5 + 215 * CGFloat(i), width: scrollView.width - 20, height: 200), supplierTable: dashBoardInfo.simInfoList[i])
            
            scrollView.addSubview(supplierTableView)
            
            dashBoardInfo.total += dashBoardInfo.simInfoList[i].count
            
            if i == dashBoardInfo.simInfoList.count - 1 {
                scrollView.contentSize = CGSize(width: scrollView.width, height: supplierTableView.frame.maxY + 20)
            }
        }
        
        subheadLbl.setTextColors(["流量卡总计：","\(dashBoardInfo.total)","张"], [KColor(0, 0, 0, 0.8), UIColor.red, KColor(0, 0, 0, 0.8)])
        
    }
    
    func setUpAccountInfoView() {
        let headLbl = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 25))
        headLbl.font = UIFont.systemFont(ofSize: 18)
        headLbl.textColor = KColor(0, 0, 0, 0.8)
        headLbl.text = "账户信息"
        scrollView.addSubview(headLbl)
        
        accountInfoView = UIView(frame: CGRect(x: 10, y: headLbl.frame.maxY + 5, width: KWidth - 20, height: 30 * CGFloat(titleArr.count)))
        accountInfoView.backgroundColor = UIColor.white
        accountInfoView.setShadow()
        scrollView.addSubview(accountInfoView)
        
        for i in 0 ..< titleArr.count {
            let cell = UIView(frame: CGRect(x: 0, y: CGFloat(i) * 30, width: accountInfoView.width, height: 30))
            accountInfoView.addSubview(cell)
            
            let line1 = UIView(frame: CGRect(x: 5, y: 29.5, width: cell.width - 10, height: 0.5))
            line1.backgroundColor = UIColor.gray
            if i != titleArr.count - 1 {
                cell.addSubview(line1)
            }
            let line2 = UIView(frame: CGRect(x: cell.width/2.0, y: 0, width: 0.5, height: 29.5))
            line2.backgroundColor = UIColor.gray
            cell.addSubview(line2)
            
            let titleLbl = UILabel(frame: CGRect(x: 20, y: 5, width: 200, height: 20))
            titleLbl.text = titleArr[i]
            titleLbl.textColor = KColor(0, 0, 0, 0.8)
            titleLbl.font = UIFont.systemFont(ofSize: 13)
            cell.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: cell.width/2.0 + 20, y: 5, width: 200, height: 20))
            valueLbl.text = valueArr[i]
            valueLbl.textColor = KColor(0, 0, 0, 0.8)
            valueLbl.font = UIFont.systemFont(ofSize: 13)
            cell.addSubview(valueLbl)
            
        }
    }
    
    @objc func showValueBtnClicked(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            btn.x = (btn.superview?.width)! - 20 - btn.width
            apiLbl.isHidden = false
        }else {
            btn.x = (btn.superview?.width)!/2.0 + 20
            apiLbl.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Mystring("总览")
        setUpScrollView()
        refreshData()
    }
//    MARK:获取网络数据
    func refreshData() {
        ProgressHUD.showInfo(withStatus: "获取中...")
        APITool.request(target: .dashBoardInfo, success: { [weak self] (result) in
            print("概览", result)
            if let resultDict = result as? NSDictionary,
                let dashBoardInfo = DashBoardInfo.deserialize(from: resultDict) {
               self!.dashBoardInfo = dashBoardInfo
            }
            self!.scrollView.removeFromSuperview()
            self!.setUpScrollView()
            self!.scrollView.mj_header.endRefreshing()
        }) { [weak self] (error) in
            print(error)
            self!.scrollView.mj_header.endRefreshing()
        }
    }
}












