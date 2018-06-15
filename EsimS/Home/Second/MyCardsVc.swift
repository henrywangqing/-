//
//  MyCardsVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/7.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MyCardsVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    
    let offsetH:CGFloat = 100
    
    var tableView: UITableView!
    
    var headerView: UIView!
    
    var footerView: UIView!
    
    var cardListInPage = [SimCard]()
    
    var headLbl: UILabel!
    
    var pageLbl: UILabel!
    
    weak var pageBtn1: UIButton!
    
    weak var pageBtn2: UIButton!
    
    var page: Int = 1
    
    var pageView: UIView!
    
    var totalNum: Int = 10
    
    let cellTitleArr = ["序号","卡号","价格","流量","原到期","续费后到期"]
    
    let proportionArr: [CGFloat] = [0.1, 0.2, 0.1, 0.1, 0.25, 0.25]
    let cellTitleXArr: [CGFloat] = [0, 0.1, 0.3, 0.4, 0.5, 0.75]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Mystring("续费清单")
        
        setUpData()
        
        setUpTableView()
        
    }
    func setUpData() {
        for _ in 0 ..< 10 {
            let card = SimCard()
            card.id = 234
            card.price = 10
            card.flow = 50
            card.expire_date = "2017-09-09"
            card.charge_expire_date = "2017-11-09"
            cardListInPage.append(card)
        }
        
    }
    
    
    func setUpPageView() {
        pageView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 40))
        view.backgroundColor = KBackgroundColor
        footerView.addSubview(pageView)
        
        for i in 0 ..< 2 {
            let pageBtn = UIButton(frame: CGRect(x: KWidth/2.0 - 130 + 180 * CGFloat(i), y: 0, width: 80, height: 40), title: ["上一页","下一页"][i], titleColor: KColor(0, 0, 0, 0.8), fontsize: 16, target:self, selector: #selector(pageBtnClicked(_ :)))
            pageView.addSubview(pageBtn)
            if i == 0 {
                pageBtn1 = pageBtn
            }else {
                pageBtn2 = pageBtn
            }
        }
        
        pageLbl = UILabel(frame: CGRect(x: KWidth/2.0 - 50, y: 0, width: 100, height: 40), color: KOrangeColor, fontsize: 14)
        pageView.addSubview(pageLbl)
        
        refreshPages()
    }
    
    func setUpHeadLbl() {
        
        headLbl = UILabel.init(frame: CGRect(x: 20, y: 10, width: 300, height: 25), color: KColor(0, 0, 0, 0.8), fontsize:18, text: "总计：\(totalNum)张")
        headerView.addSubview(headLbl)
    }
    func setUpTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!), style:.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 1
        tableView.estimatedSectionFooterHeight = 1
        tableView.backgroundColor = KBackgroundColor
        tableView.rowHeight = 40
        tableView.contentInset = UIEdgeInsetsMake(0, 0, max(550 - tableView.height + offsetH, offsetH), 0)
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
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 75))
        footerView.backgroundColor = KBackgroundColor
        tableView.tableFooterView = footerView
        setUpPageView()
        
    }
    
    func setUpHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 75))
        headerView.backgroundColor = KBackgroundColor
        tableView.tableHeaderView = headerView
        
        setUpHeadLbl()
        
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: headLbl.frame.maxY + 10, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: cellTitleArr[i])
            headerView.addSubview(lbl)
        }
    }
    
    
    func refreshPages() {
        let totalPage = totalNum%10 == 0 ? (totalNum/10) : totalNum/10 + 1
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
        
        if totalNum == 0 {
            pageLbl.text = "共0页"
        }
        pageLbl.textAlignment = .center
    }
    
    @objc func pageBtnClicked(_ btn:UIButton) {
        
        if btn == pageBtn1 {
            page -= 1
        }else {
            page += 1
        }
        
        tableView.reloadData()
        
        refreshPages()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let card = cardListInPage[indexPath.row]
        let txtArr = ["\(indexPath.row + 1)","\(card.id)","\(card.price)","\(card.flow)",card.expire_date,card.charge_expire_date]
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: 0, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: txtArr[i]!)
            
            cell.contentView.addSubview(lbl)
        }
        
        return cell
    }

}
