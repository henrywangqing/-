//
//  ShowRenewListVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
 
class ShowRenewListVc: BaseVc, UITableViewDataSource, UITableViewDelegate {
    
    var chargeCardsResult = ChargeCardsResult()
    
    var page: Int = 1
    
    let offsetH:CGFloat = 200
    
    var tableView: UITableView!
    
    var headerView: UIView!
    
    var footerView: UIView!
    
    var headLbl: UILabel!
    
    var pageLbl: UILabel!
    
    weak var pageBtn1: UIButton!
    
    weak var pageBtn2: UIButton!
     
    var pageView: UIView!
    
    var submitBtn: UIButton!
    
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
  
        headLbl = UILabel.init(frame: CGRect(x: 10, y: 10, width: 300, height: 25), color: KColor(0, 0, 0, 0.8), fontsize:18, text: "总计：\(chargeCardsResult.simList.count)张")
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
        let totalPage = chargeCardsResult.simList.count%10 == 0 ? (chargeCardsResult.simList.count/10) : chargeCardsResult.simList.count/10 + 1
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
        
        if chargeCardsResult.simList.count == 0 {
            pageLbl.text = "共0页"
        }
        pageLbl.textAlignment = .center
    }
    
    @objc func pageBtnClicked(_ btn:UIButton) {
        refreshData(pageNumber: btn == pageBtn1 ? page - 1 : page + 1)
        
    }
   
    
    func refreshData(pageNumber: Int) {
        ProgressHUD.show(withStatus: "刷新中...")
        
        APITool.request(target: .getRenewedCardInfo(simNoList: chargeCardsResult.simList, sim_type: 0, month: chargeCardsResult.month, pageNumber: pageNumber, pageSize: 10), success: { [weak self] (result) in
            print("结果",result)
            
            if let resultDict = result as? NSDictionary,
                let chargeCardsResult = ChargeCardsResult.deserialize(from: resultDict) {
                let month = self!.chargeCardsResult.month
                
                self!.chargeCardsResult = chargeCardsResult
                self!.chargeCardsResult.month = month
                
                self!.page = pageNumber
                self!.tableView.removeFromSuperview()
                self!.setUpTableView()
            }
            
        }) { (error) in
            print(error)
            
        }
    }
 
    @objc func submitBtnClicked() {
        ProgressHUD.show(withStatus: "提交中...")
        APITool.request(target: .submitOrder(simNoList: chargeCardsResult.simList, month: chargeCardsResult.month), success: { [weak self] (result) in
            print("结果",result)
            
            if let resultDict = result as? NSDictionary,
                let bill = Bill.deserialize(from: resultDict) {
                let vc = ConfirmPaymentVc()
                vc.bill = bill
                vc.bill.month = self!.chargeCardsResult.month
                vc.bill.simList = self!.chargeCardsResult.simList
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
        if (page - 1) * 10 + indexPath.row < chargeCardsResult.simList.count {
            chargeCardsResult.simList.remove(at: (page - 1) * 10 + indexPath.row)
            refreshData(pageNumber: 1)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargeCardsResult.chargeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let card = chargeCardsResult.chargeList[indexPath.row]
        let txtArr = ["\(indexPath.row + 1)",card.imsi,"\(card.price)","\(card.flow)",NSString.yyyyMMddFromString(card.expire_date),NSString.yyyyMMddFromString(card.charge_expire_date)]
        for i in 0 ..< proportionArr.count {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: 0, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: txtArr[i])
            lbl.numberOfLines = 0 
            cell.contentView.addSubview(lbl)
        }
        
        return cell
    }
    
}






