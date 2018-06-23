//
//  CardManagementVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/6.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class CardManagementVc: BaseVc {
    
    let titleArr = ["白马号码:","套餐名称:","开始日期:","结束日期:","订单号码:"]
    
    var scrollView: UIScrollView!
    
    var headerView: UIView!
    
    var cardDiagramView: CardDiagramView!
    
    var card = Card()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButton()
 
        setUpScrollView()
        
    }
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH -  (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = KBackgroundColor
        view.addSubview(scrollView)
        
        setUpHeaderView()
        
        setUpCardDiagramView()
    }
    
    func setUpHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 20, width: KWidth, height: 140))
        headerView.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        
        for i in 0 ..< 5 {
            let titleLbl = UILabel(frame: CGRect(x: 10, y: 10 + CGFloat(i) * 25, width: UILabel.getWidth(titleArr[i], UIFont.systemFont(ofSize: 14)), height: 20), color: KColor(0, 0, 0, 0.8), fontsize: 13, text: titleArr[i])
            titleLbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            headerView.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 15, y: titleLbl.y, width: 300, height: titleLbl.height), color: titleLbl.textColor, fontsize: 13, text: "未知")
            
            headerView.addSubview(valueLbl)
        }
        
    }
    func setUpCardDiagramView() {
        
        card.flow = 50
        card.flow_used = 30
        card.flow_left = card.flow - card.flow_used
        
        let cardDiagramView = CardDiagramView(frame: CGRect(x: 0, y: headerView.frame.maxY + 20, width: KWidth, height: 170), card: card)
        
        scrollView.addSubview(cardDiagramView)
    }
    
    
    func setBarButton() {
        title = "卡片管理"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc func dismissSelf() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}














