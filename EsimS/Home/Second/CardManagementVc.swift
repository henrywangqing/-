//
//  CardManagementVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/6.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class CardManagementVc: BaseVc {
    
    let cellSpace: CGFloat = 5
    
    let sectionSpace: CGFloat = 10
    
    let cellH: CGFloat = 15
    
    let titleArr = [["查询时间:"], ["白马号码:", "iccid:", "imsi:", "msisdn:"], ["运营商:", "所属商户:", "到期日期:", "套餐名称:"], ["开卡时间:", "订单号码:", "状态:", "备注:"]]
    
    var valueArr = [[String]]()
    
    var scrollView: UIScrollView!
    
    var bottomView: UIView!
    
    var contentView: UIView!
    
    var flowTableView: FlowTableView!
    
    var operateBtn: UIButton!
    
    var card = Card()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButton()
        
        setUpData()
 
        setUpScrollView()
        
        setUpBottomView()
    }
    
    
    func setUpBottomView() {
       
        bottomView = UIView(frame: CGRect(x: 0, y: KHeight - KStatusBarH - (navigationController?.navigationBar.height)! - 55, width: KWidth, height: 55))
        bottomView.backgroundColor = UIColor.white
        bottomView.setShadow()
        view.addSubview(bottomView)
        
        operateBtn = UIButton(frame: CGRect(x: 80, y: 10, width: 80, height: 30), title: card.status_info == "停机" ? "激活" : "暂停", titleColor: UIColor.black, backgroundColor: UIColor.white, fontsize: 15, target: self, selector: #selector(operateBtnClicked))
        operateBtn.setBorder(width: 0.5, color: KColor(0, 0, 0, 0.5), cornerRadius: 15)
        bottomView.addSubview(operateBtn)
        
        let refreshBtn = UIButton(frame: CGRect(x: KWidth - operateBtn.x - operateBtn.width, y: operateBtn.y, width: operateBtn.width, height: operateBtn.height), title: "刷新", titleColor: UIColor.black, backgroundColor: operateBtn.backgroundColor!, fontsize: 15, target: self, selector: #selector(refreshBtnClicked))
        refreshBtn.setBorder(width: 0.5, color: KColor(0, 0, 0, 0.5), cornerRadius: 15)
        bottomView.addSubview(refreshBtn)
    }
    @objc func refreshBtnClicked() {
        ProgressHUD.show(withStatus: "刷新中...")
        APITool.request(target: .refreshCardInfo(iccid: card.iccid), success: { [weak self] (result) in
            print("刷新卡信息", result)
            if let resultArr = result as? [NSDictionary],
            let cards = [Card].deserialize(from: resultArr) {
                if cards.count > 0 {
                    self!.card = cards[0]!
                    self!.setUpData()
                    self!.scrollView.removeFromSuperview()
                    self!.setUpScrollView()
                    self!.bottomView.removeFromSuperview()
                    self!.setUpBottomView()
                }
                
            }
        }) { (error) in
            print(error)
        }
    }
    @objc func operateBtnClicked() {
        let alert = UIAlertController(style: .alert, title: "确定\((operateBtn.title(for: .normal))!)吗", titleA: "确定", colorA: UIColor.red, handlerA: { (action) in
            
        }, titleB: "取消", colorB: UIColor.black, handlerB: nil)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setUpData() {
        
        card.flow_left = card.flow - card.flow_used
        
        valueArr = [[NSString.yyyyMMddHHmmssFromString(card.query_time)], [card.No, card.iccid, card.imsi, card.msisdn], [card.agent, card.company, NSString.yyyyMMddFromString(card.expire_date), card.pkg_name], [NSString.yyyyMMddHHmmssFromString(card.open_time), card.order_no, card.status_info, card.mark]]
    }
  
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH -  (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = KBackgroundColor
        view.addSubview(scrollView)
        
        setUpcontentView()
        
        setUpFlowTableView()
    }
    
    func setUpcontentView() {
        contentView = UIView(frame: CGRect(x: 0, y: 10, width: KWidth, height: 100))
        contentView.backgroundColor = KBackgroundColor
        scrollView.addSubview(contentView)
        
        var sectionY: CGFloat = 0
        for i in 0 ..< titleArr.count {
            let sectionH = CGFloat(titleArr[i].count + 1) * cellSpace + cellH * CGFloat(titleArr[i].count)
            if i > 0 {
                sectionY += ((view.viewWithTag(500 + i - 1)?.height)! + sectionSpace)
                
            }
            let sectionView = UIView(frame: CGRect(x: 0, y: sectionY, width: KWidth, height: sectionH))
            sectionView.backgroundColor = UIColor.white
            sectionView.tag = 500 + i
            
            contentView.addSubview(sectionView)
            
            for j in 0 ..< titleArr[i].count {
                let titleLbl = UILabel(frame: CGRect(x: 10, y: cellSpace + CGFloat(j) * (cellH + cellSpace), width: 100, height: cellH), color: KColor(0, 0, 0, 0.8), fontsize:13, weight:.bold, text: titleArr[i][j])
                titleLbl.width = UILabel.getWidth(titleArr[i][j], titleLbl.font)
                sectionView.addSubview(titleLbl)
                
                let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 15, y: titleLbl.y, width: 300, height: titleLbl.height), color: titleLbl.textColor, fontsize: 13, text: valueArr[i][j])
                
                sectionView.addSubview(valueLbl)
            }
        }
        
        contentView.height = (view.viewWithTag(500 + titleArr.count - 1)?.frame.maxY)!
        
        
    }
    func setUpFlowTableView() {
        
        flowTableView = FlowTableView(frame: CGRect(x: 0, y: contentView.frame.maxY + 10, width: KWidth, height: 170), card: card)

        scrollView.addSubview(flowTableView)
        
        scrollView.contentSize = CGSize(width: scrollView.width, height: flowTableView.frame.maxY + 50)
    }
    
    
    func setBarButton() {
        title = "卡片管理"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc func dismissSelf() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}














