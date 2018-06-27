//
//  OrderCell.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/27.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

//"is_valid" = 0;
//"power_on" = 0;

class OrderCell: UITableViewCell {
    var order: Order!
    var titleArr = ["订单号码", "下单时间", "订单状态", "支付金额", "订单类型", "总卡数", "期限（月）"]
    var orderNoLbl = UILabel()
    var orderStatusLbl = UILabel()
    var orderTypeLbl = UILabel()
    var orderTimeLbl = UILabel()
    var amountLbl = UILabel()
    
    var heightArr: [CGFloat] = [40, 60, 40]
    var yArr: [CGFloat] = [0, 40, 100]
    var colorArr = [UIColor.white, KColor(235, 245, 255, 0.4), UIColor.white]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = KBackgroundColor
        
        for i in 0 ..< 3 {
            let sectionView = UIView(frame: CGRect(x: 0, y: yArr[i], width: KWidth, height: heightArr[i]))
            sectionView.backgroundColor = colorArr[i]
            if i == 0 {
                sectionView.addSubview(orderNoLbl)
                sectionView.addSubview(orderStatusLbl)
                
            } else if i == 1 {
                sectionView.addSubview(orderTypeLbl)
                sectionView.addSubview(orderTimeLbl)
            } else {
                sectionView.addSubview(amountLbl)
            }
        }
        
        
    }
    override func layoutSubviews() {
        orderNoLbl.set(frame: CGRect(x: 15, y: 10, width: 300, height: 20), color: UIColor.black, fontsize: 15, weight: .bold, text: order.order_no)
        
        orderStatusLbl.set(frame: CGRect(x: KWidth - 200 - 15, y: orderNoLbl.y, width: 200, height: orderNoLbl.height), color: orderNoLbl.textColor, alignment: .right, fontsize: 15, weight: .bold, text: order.order_status)
        
      
        orderTypeLbl.set(frame: CGRect(x: 20, y: orderNoLbl.y, width: 100, height: 20), color: KBlueColor, fontsize: 16, weight: .bold, text: order.order_type)
        orderTypeLbl.width = UILabel.getWidth(orderTypeLbl.text!, orderTypeLbl.font)
        
        orderTypeLbl.set(frame: CGRect(x: 20, y: orderNoLbl.y, width: 100, height: 20), color: UIColor.black, fontsize: 16, weight: .bold, text: "订单类型:\(order.order_type)")
        
        orderTimeLbl.set(frame: CGRect(x: 20, y: orderNoLbl.frame.maxY + 5, width: 100, height: 20), color: UIColor.black, fontsize: 16, weight: .bold, text: "下单时间:\(order.create_time)")
        
        amountLbl.set(frame: CGRect(x: KWidth - 300, y: 10, width: 300, height: 20), color: KBlueColor, alignment: .right)
        amountLbl.setTextFonts(["共\(order.sum)张卡 付款：", "\(order.fee)"], [UIFont.systemFont(ofSize: 13, weight: .regular), UIFont.systemFont(ofSize: 13, weight: .bold)])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




