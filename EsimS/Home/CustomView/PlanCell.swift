//
//  PlanCell.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/17.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class PlanCell: UITableViewCell {
    
    var plan: Plan!
    var padView = UIView()
    var titleLbl = UILabel()
    var networkLbl = UILabel()
    var detailLbl = UILabel()
    var finalPriceLbl = UILabel()
    var originalPriceLbl = UILabel()
    var discountBtn = UIButton()
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        contentView.backgroundColor = KBackgroundColor
        padView.layer.cornerRadius = 5
        padView.backgroundColor = UIColor.white
        padView.layer.borderWidth = 0.5
        padView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(padView)
        
        titleLbl.font = UIFont.systemFont(ofSize: 15)
        titleLbl.textColor = KColor(0, 0, 0, 0.8)
        padView.addSubview(titleLbl)
        
        
        networkLbl.textColor = KColor(0, 0, 0, 0.6)
        networkLbl.font = UIFont.systemFont(ofSize: 13)
        padView.addSubview(networkLbl)
        
        detailLbl.textColor = networkLbl.textColor
        detailLbl.font = UIFont.systemFont(ofSize: 13)
        padView.addSubview(detailLbl)
        
        finalPriceLbl.textAlignment = .right
        finalPriceLbl.textColor = UIColor.red
        finalPriceLbl.font = UIFont.systemFont(ofSize: 17)
        padView.addSubview(finalPriceLbl)
        
        originalPriceLbl.textAlignment = .right
        originalPriceLbl.textColor = networkLbl.textColor
        originalPriceLbl.font = UIFont.systemFont(ofSize: 13)
        padView.addSubview(originalPriceLbl)
        
        discountBtn.setTitleColor(UIColor.red, for: .normal)
        discountBtn.layer.cornerRadius = 2
        discountBtn.layer.borderWidth = 0.5
        discountBtn.layer.borderColor = UIColor.red.cgColor
        discountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        padView.addSubview(discountBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        padView.frame = CGRect(x: 10, y: 10, width: KWidth - 20, height: contentView.height - 20)
        
        titleLbl.text = "\(plan.country)\(plan.name)"
        titleLbl.frame = CGRect(x: 10, y: 8, width: width - 150, height: 40)
        
        networkLbl.text = plan.network
        networkLbl.frame = CGRect(x: titleLbl.x, y: titleLbl.frame.maxY + 10, width: UILabel.getWidth(plan.network, networkLbl.font), height: 20)
        
        detailLbl.text = plan.detail
        detailLbl.frame = CGRect(x: networkLbl.frame.maxX, y: networkLbl.y, width: (titleLbl.width - networkLbl.frame.maxX), height: 20)
        
        finalPriceLbl.text = plan.finalPrice
        let finalPriceW = UILabel.getWidth(plan.finalPrice, finalPriceLbl.font)
        finalPriceLbl.frame  = CGRect(x: padView.width - finalPriceW - 10, y: 25, width: finalPriceW, height: 20)
        
        
        
        let priceString = NSMutableAttributedString.init(string: plan.originalPrice)
        priceString.addAttribute(.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        
        originalPriceLbl.attributedText = priceString
        
        let originalPriceW = UILabel.getWidth(plan.originalPrice, originalPriceLbl.font)
        originalPriceLbl.frame = CGRect(x: finalPriceLbl.x - originalPriceW - 5, y: 30, width: originalPriceW, height: 12)
        
        discountBtn.setTitle(plan.discount, for: .normal)
        let discountBtnW = 15 + UILabel.getWidth(plan.discount, (discountBtn.titleLabel?.font)!)
        discountBtn.frame = CGRect(x: padView.width - 10 - discountBtnW, y: finalPriceLbl.frame.maxY + 8, width: discountBtnW, height: 18)
        
    }
}



