//
//  ShowRenewListVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
 
class ShowRenewListVc: BaseVc, UITableViewDataSource, UITableViewDelegate {
    
    let offsetH:CGFloat = 200
    
    var tableView: UITableView!
    
    var headerView: UIView!
    
    var footerView: UIView!
    
    var chargeList = [Card]()
    
    var simList = [Int]()
    
    var headLbl: UILabel!
    
    var pageLbl: UILabel!
    
    weak var pageBtn1: UIButton!
    
    weak var pageBtn2: UIButton!
    
    var page: Int = 1
     
    var pageView: UIView!
    
    var submitBtn: UIButton!
    
    var month: Int = 1
     
    let cellTitleArr = ["序号","卡号","价格","流量","原到期","续费后到期"]
    
    let proportionArr: [CGFloat] = [0.1, 0.2, 0.1, 0.1, 0.25, 0.25]
    let cellTitleXArr: [CGFloat] = [0, 0.1, 0.3, 0.4, 0.5, 0.75]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Mystring("续费清单")
         
        setUpTableView()
        
    }
    
   
    func setUpsubmitBtn() {
        submitBtn = UIButton(frame: CGRect(x: 20, y: pageView.frame.maxY + 10, width: KWidth - 40, height: 40), title: "提交订单", imageName: "", titleColor: UIColor.white, backgroundColor: KBlueColor, fontsize: 15, target: self, selector: #selector(submitBtnClicked))
        
        footerView.addSubview(submitBtn)
        
    }
     
 
    func setUpPageView() {
        pageView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 40))
        view.backgroundColor = KBackgroundColor
        footerView.addSubview(pageView)
        
        for i in 0 ..< 2 {
            let pageBtn = UIButton(frame: CGRect(x: KWidth/2.0 - 140 + 200 * CGFloat(i), y: 0, width: 80, height: 40), title: ["上一页","下一页"][i], titleColor: KColor(0, 0, 0, 0.8), fontsize: 16, target:self, selector: #selector(pageBtnClicked(_ :)))
            pageView.addSubview(pageBtn)
            if i == 0 {
                pageBtn1 = pageBtn
            }else {
                pageBtn2 = pageBtn
            }
        }
        
        
        pageLbl = UILabel(frame: CGRect(x: KWidth/2.0 - 60, y: 0, width: 120, height: 40), color: UIColor.red, fontsize: 14)
        pageView.addSubview(pageLbl)
        
        refreshPages()
    }
    
    func setUpHeadLbl() {
  
        headLbl = UILabel.init(frame: CGRect(x: 10, y: 10, width: 300, height: 25), color: KColor(0, 0, 0, 0.8), fontsize:18, text: "总计：\(simList.count)张")
        headerView.addSubview(headLbl)
        
        let hintLbl = UILabel.init(frame: CGRect(x: 10, y: headLbl.frame.maxY + 5, width: 300, height: 20), color: KColor(0, 0, 0, 0.8), fontsize:14, text: "向左滑动可从列表中删除")
        headerView.addSubview(hintLbl)
    }
    func setUpTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!), style:.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 1
        tableView.estimatedSectionFooterHeight = 1
        tableView.backgroundColor = KBackgroundColor
        tableView.rowHeight = 40
        tableView.contentInset = UIEdgeInsetsMake(0, 0, max(555 - tableView.height + offsetH, offsetH), 0)
        view.addSubview(tableView)
        
        setUpHeaderView()
        
        setUpFooterView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func setUpFooterView() {
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 200))
        footerView.backgroundColor = KBackgroundColor
        tableView.tableFooterView = footerView
        setUpPageView()
        setUpsubmitBtn()
        
    }
    
    func setUpHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 95))
        headerView.backgroundColor = KBackgroundColor
        tableView.tableHeaderView = headerView
        
        setUpHeadLbl()
        
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: headLbl.frame.maxY + 25, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: cellTitleArr[i])
            headerView.addSubview(lbl)
        }
    }
    
    
    func refreshPages() {
        let totalPage = simList.count%10 == 0 ? (simList.count/10) : simList.count/10 + 1
        if page <= 1 {
            pageBtn1.isEnabled = false
            pageBtn1.setTitleColor(UIColor.gray, for: .normal)
        }else {
            pageBtn1.isEnabled = true
            pageBtn1.setTitleColor(UIColor.black, for: .normal)
        }
        
        if page >= totalPage {
            pageBtn2.isEnabled = false
            pageBtn2.setTitleColor(UIColor.gray, for: .normal)
        }else {
            pageBtn2.isEnabled = true
            pageBtn2.setTitleColor(UIColor.black, for: .normal)
        }
    
        pageLbl.text = "共\(totalPage)页，第\(page)页"
        
        if simList.count == 0 {
            pageLbl.text = "共0页"
        }
        pageLbl.textAlignment = .center
    }
    
    @objc func pageBtnClicked(_ btn:UIButton) {
        ProgressHUD.show(withStatus: "刷新中...")
        
        APITool.request(target: .getRenewedCardInfo(simNoList: simList, sim_type: 0, month: month, pageNumber: btn == pageBtn1 ? page - 1 : page + 1, pageSize: 10), success: { [weak self] (result) in
            print("结果",result)
             
            if let resultDict = result as? NSDictionary,
               let chargeList = resultDict["chargeList"] as? [NSDictionary] {
                self!.dealWithResult(chargeList: chargeList)
                
                if btn == self!.pageBtn1 {
                    self!.page -= 1
                }else {
                    self!.page += 1
                }
                self!.refreshPages()
                
            }
            
        }) { (error) in
            print(error)
            
        }
    }
    func dealWithResult(chargeList: [NSDictionary]) {
        var cards = [Card]()
        for dic in chargeList {
            if let card = Card.deserialize(from: dic) {
                cards.append(card)
            }
        }
        self.chargeList = cards
        tableView.reloadData()
    }
 
    @objc func submitBtnClicked() {
        ProgressHUD.show(withStatus: "提交中...")
        APITool.request(target: .submitOrder(simNoList: simList, month: month), success: { [weak self] (result) in
            print("结果",result)
            
            if let resultDict = result as? NSDictionary,
                let order = Order.deserialize(from: resultDict) {
                let vc = ConfirmPaymentVc()
                vc.order = order
                vc.month = self!.month
                vc.simList = self!.simList 
            self!.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            
        }) { (error) in
            print(error)
            
        }
        
    }
//    MARK: tableviewdelegate
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (page - 1) * 10 + indexPath.row < simList.count {
            simList.remove(at: (page - 1) * 10 + indexPath.row)
            
        }
        
        ProgressHUD.show(withStatus: "刷新中...")
       
        APITool.request(target: .getRenewedCardInfo(simNoList: simList, sim_type: 0, month: month, pageNumber: 1, pageSize: 10), success: { [weak self] (result) in
            print("结果",result)
            
            if let resultDict = result as? NSDictionary,
                let chargeList = resultDict["chargeList"] as? [NSDictionary] {
                self!.dealWithResult(chargeList: chargeList)
                
                self!.page = 1
                self!.refreshPages()
                
            }
            
        }) { (error) in
            print(error)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let card = chargeList[indexPath.row]
        let txtArr = ["\(indexPath.row + 1)",card.imsi,"\(card.price)","\(card.flow)",NSString.yyyyMMddFromString(card.expire_date),NSString.yyyyMMddFromString(card.charge_expire_date)]
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: 0, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: txtArr[i])
            lbl.numberOfLines = 0 
            cell.contentView.addSubview(lbl)
        }
        
        return cell
    }
    
}






