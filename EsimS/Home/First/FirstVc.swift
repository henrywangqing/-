//
//  FirstVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
import SVProgressHUD

class FirstVc: BaseVc {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    weak var apiLbl: UILabel!
    var scrollView = UIScrollView()
    var accountInfoView: UIView!
    let titleArr = ["账号名称","注册日期","账号余额",
                    "佣金余额","移动套餐折扣","电信套餐折扣",
                    "联通套餐折扣","api key"]
    let valueArr = [DataManager.currentAccount().username,"2018-05-10","¥\(DataManager.currentAccount().companyBalance)",
                    "¥3291.80","10%","10%",
                    "10%","986434532453545"]
  
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (tabBarController?.tabBar.height)! - (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        setUpAccountInfoView()
        setUpBusinessDiagramView()
    }
    
    func refreshData() {
        SVProgressHUD.show(withStatus: "获取中...")
        APITool.request(target: .firstPage, success: { [weak self] (result) in
            print("结果",result)
            
        }) { (error) in
            print(error)
            
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
        subheadLbl.setTextColors(["流量卡总计：","100","张"], [KColor(0, 0, 0, 0.8), KBlueColor, KColor(0, 0, 0, 0.8)])
        scrollView.addSubview(subheadLbl)
        
        var b = Business()
        b.name = "中国联通"
        b.total = 100
        b.inUse = 20
        b.unknown = 20
        b.silent = 20
        b.test = 20
        b.outage = 20
        let diagramView1 = DiagramView(frame: CGRect(x: 10, y: subheadLbl.frame.maxY + 5, width: scrollView.width - 20, height: 200), business:b)
        
        scrollView.addSubview(diagramView1)
        
        scrollView.contentSize = CGSize(width: scrollView.width, height: diagramView1.frame.maxY + 20)
         
    }
    
    func setUpAccountInfoView() {
        let headLbl = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 25))
        headLbl.font = UIFont.systemFont(ofSize: 18)
        headLbl.textColor = KColor(0, 0, 0, 0.8)
        headLbl.text = "账户信息"
        scrollView.addSubview(headLbl)
        
        accountInfoView = UIView(frame: CGRect(x: 10, y: headLbl.frame.maxY + 5, width: KWidth - 20, height: 240))
        accountInfoView.backgroundColor = UIColor.white
        accountInfoView.setShadow()
        scrollView.addSubview(accountInfoView)
         
        for i in 0 ..< 8 {
            let cell = UIView(frame: CGRect(x: 0, y: CGFloat(i) * 30, width: accountInfoView.width, height: 30))
            accountInfoView.addSubview(cell)
            
            let line1 = UIView(frame: CGRect(x: 5, y: 29.5, width: cell.width - 10, height: 0.5))
            line1.backgroundColor = UIColor.gray
            if i != 7 {
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
            
            if i == 7 {
                apiLbl = valueLbl
                valueLbl.isHidden = true
                
                let showValueBtn = UIButton(frame: CGRect(x:valueLbl.x, y: 2, width: 50, height: 26), title: Mystring("显示"), imageName: "", titleColor: UIColor.white, fontsize: 14, target: self, selector: #selector(showValueBtnClicked(_:)))
                showValueBtn.setBackgroundImage(UIColor.createImageWithColor(KBlueColor), for: .normal) 
                showValueBtn.setBackgroundImage(UIColor.createImageWithColor(UIColor.red), for: .selected)
                showValueBtn.setTitle("隐藏", for: .selected)
                showValueBtn.titleLabel?.font = valueLbl.font
                cell.addSubview(showValueBtn)
            }
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
     
}












