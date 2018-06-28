//
//  OrderDetailVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/27.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class OrderDetailVc: BaseVc {
    
    let cellTopSpace: CGFloat = 8
    
    let cellSpace: CGFloat = 2
    
    let sectionSpace: CGFloat = 15
    
    let cellH: CGFloat = 16
    
    var titleArr = [["订单号码:", "下单时间:", "订单状态:"], ["支付方式:", "支付金额:", "支付时间:", "支付状态:"], ["订单类型:", "总卡数:", "期限（月）:", "到期日期:", "是否开机:"]]
    
    var valueArr = [[String]] ()
    
    var order: Order!
    
    var scrollView: UIScrollView!
    
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单详情"
        
        setUpData()
        
        setUpScrollView()
    }
    
    func setUpData() {
        valueArr = [[order.order_no, NSString.yyyyMMddHHmmssFromString(order.create_time), order.order_status], [order.pay_type, "¥\(String(format: "%.2f",order.fee))", NSString.yyyyMMddHHmmssFromString(order.pay_time), order.pay_status], [order.order_type, "\(order.sum)张", "\(order.month)", NSString.yyyyMMddFromString(order.expire_time), order.power_on == true ? "是" : "否"]]
        
    }
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH -  (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = KBackgroundColor
        view.addSubview(scrollView)
        
        setUpcontentView()
        
    }
    func setUpcontentView() {
        contentView = UIView(frame: CGRect(x: 0, y: 30, width: KWidth, height: 100))
        contentView.backgroundColor = KBackgroundColor
        scrollView.addSubview(contentView)
        
        var sectionY: CGFloat = 0
        for i in 0 ..< titleArr.count {
            let sectionH = cellTopSpace * 2 + CGFloat(titleArr[i].count - 1) * cellSpace + cellH * CGFloat(titleArr[i].count)
            if i > 0 {
                sectionY += ((view.viewWithTag(500 + i - 1)?.height)! + sectionSpace)
                
            }
            let sectionView = UIView(frame: CGRect(x: 0, y: sectionY, width: KWidth, height: sectionH))
            sectionView.backgroundColor = UIColor.white
           
            sectionView.tag = 500 + i
            sectionView.layer.borderWidth = 0.5
            sectionView.layer.borderColor = KColor(0, 0, 0, 0.2).cgColor
            
            contentView.addSubview(sectionView)
            
            for j in 0 ..< titleArr[i].count {
                let titleLbl = UILabel(frame: CGRect(x: 15, y: cellTopSpace + CGFloat(j) * (cellH + cellSpace), width: 100, height: cellH), color: KColor(0, 0, 0, 0.8), fontsize:14, weight:.bold, text: titleArr[i][j])
                titleLbl.width = UILabel.getWidth(titleArr[i][j], titleLbl.font)
                sectionView.addSubview(titleLbl)
                
                let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 15, y: titleLbl.y, width: 300, height: titleLbl.height), color: titleLbl.textColor, fontsize: 14, text: valueArr[i][j])
                
                sectionView.addSubview(valueLbl)
            }
        }
        
        contentView.height = (view.viewWithTag(500 + titleArr.count - 1)?.frame.maxY)!
        scrollView.contentSize = CGSize(width: KWidth, height: contentView.frame.maxY + 50)
    }
}









