//
//  PlanDetailCell.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/19.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit


class PlanDetailCell: UITableViewCell {
     
    var titleLbl = UILabel()
    var networkLbl = UILabel()
    var finalPriceLbl = UILabel()
    var originalPriceLbl = UILabel()
    var discountBtn = UIButton()
    var line = UIView()
    var feature1 = UILabel()
    var feature2 = UILabel()
    var feature3 = UILabel()
    var feature4 = UILabel()
    
    var prosLbl = UILabel()
    var detailLbl = UILabel()
    var padView = UIView()
    
    var plan: Plan!
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = KBackgroundColor
        contentView.addSubview(padView)
        padView.layer.cornerRadius = 5
        padView.layer.borderColor = UIColor.lightGray.cgColor
        padView.layer.borderWidth = 0.5
        padView.backgroundColor = UIColor.white
        
        
        
        if reuseIdentifier == "First" {
            titleLbl.font = UIFont.systemFont(ofSize: 16)
            titleLbl.numberOfLines = 0
            titleLbl.textColor = UIColor.black
            padView.addSubview(titleLbl)
            networkLbl.textColor = KColor(0, 0, 0, 0.8)
            networkLbl.font = UIFont.systemFont(ofSize: 13)
            padView.addSubview(networkLbl)
            finalPriceLbl.font = UIFont.systemFont(ofSize: 18)
            finalPriceLbl.textColor = UIColor.red
            padView.addSubview(finalPriceLbl)
            originalPriceLbl.textColor = KColor(0, 0, 0, 0.4)
            originalPriceLbl.font = UIFont.systemFont(ofSize: 13)
            padView.addSubview(originalPriceLbl)
            discountBtn.setTitleColor(UIColor.red, for: .normal)
            discountBtn.layer.cornerRadius = 3
            discountBtn.layer.borderWidth = 0.5
            discountBtn.layer.borderColor = UIColor.red.cgColor
            discountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            padView.addSubview(discountBtn)
            line.backgroundColor = UIColor.lightGray
            padView.addSubview(line)
            feature1.font = UIFont.systemFont(ofSize: 13)
            feature1.textColor = KColor(0, 0, 0, 0.6)
            padView.addSubview(feature1)
            feature2.font = feature1.font
            feature2.textColor = feature1.textColor
            padView.addSubview(feature2)
            feature3.font = feature1.font
            feature3.textColor = feature1.textColor
            padView.addSubview(feature3)
            feature4.font = feature1.font
            feature4.textColor = feature1.textColor
            padView.addSubview(feature4)
        } else if reuseIdentifier == "Second" {
            prosLbl.textColor = KColor(0, 0, 0, 0.8)
            prosLbl.font = UIFont.systemFont(ofSize: 14)
            prosLbl.textAlignment = .center
            padView.addSubview(prosLbl)
        } else {
            titleLbl.font = UIFont.systemFont(ofSize: 16)
            titleLbl.numberOfLines = 0
            titleLbl.textColor = KColor(0, 0, 0, 0.8)
            padView.addSubview(titleLbl)
            detailLbl.font = UIFont.systemFont(ofSize: 13)
            detailLbl.textColor = KColor(0, 0, 0, 0.6)
            detailLbl.numberOfLines = 0
            padView.addSubview(detailLbl)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        padView.frame = CGRect(x: 10, y: 10, width: KWidth - 20, height: height - 20)
        
        if reuseIdentifier == "First" {
            
            
            titleLbl.text = "\(plan.country)\(plan.name)"
            titleLbl.frame = CGRect(x: 12, y: 12, width: padView.width - 50, height: UILabel.getHeight(padView.width - 50, titleLbl.text!, titleLbl.font))
            
            networkLbl.text = plan.network
            networkLbl.frame = CGRect(x: titleLbl.x, y: titleLbl.frame.maxY + 5, width: 300, height: 20)
            
            finalPriceLbl.text = plan.finalPrice
            finalPriceLbl.frame = CGRect(x: titleLbl.x, y: networkLbl.frame.maxY + 15, width: UILabel.getWidth(finalPriceLbl.text!, finalPriceLbl.font), height: 25)
            
            let string = NSMutableAttributedString.init(string: plan.originalPrice)
            string.addAttributes([.strikethroughStyle : NSNumber.init(value: 1)], range: NSRange(location: 0, length: string.length))
            originalPriceLbl.attributedText = string
            
            originalPriceLbl.frame = CGRect(x: finalPriceLbl.frame.maxX + 3, y: finalPriceLbl.y + 5, width: UILabel.getWidth(originalPriceLbl.text!, originalPriceLbl.font), height: 15)
            
            discountBtn.setTitle(plan.discount, for: .normal)
            discountBtn.frame = CGRect(x: originalPriceLbl.frame.maxX + 5, y: finalPriceLbl.y + 3.5, width: UILabel.getWidth(discountBtn.title(for: .normal)!, UIFont.systemFont(ofSize: 13)) + 8, height: 18)
            
            line.frame = CGRect(x: 5, y: finalPriceLbl.frame.maxY + 15, width: padView.width - 10, height: 0.5)
            
            feature1.text = "无需开通国漫"
            feature1.frame = CGRect(x: titleLbl.x, y: line.frame.maxY + 12, width: 300, height: 15)
            
            feature2.text = "境外当地流量"
            feature2.frame = CGRect(x: padView.width/2.0 - 20, y: feature1.y, width: feature1.width, height: 15)
            
            feature3.text = "未使用可退订"
            feature3.frame = CGRect(x: titleLbl.x, y: feature1.frame.maxY + 12, width: feature1.width, height: 15)
            
            feature4.text = "三步激活使用"
            feature4.frame = CGRect(x: feature2.x, y: feature3.y, width: feature1.width, height: 15)
            
        } else if reuseIdentifier == "Second" {
            prosLbl.text = "购买成功   -   落地激活   -   开始使用"
            prosLbl.frame = CGRect(x: 0, y: padView.height/2.0 - 10, width: padView.width, height: 20)
        } else {
            titleLbl.text = "套餐介绍"
            titleLbl.frame = CGRect(x: 12, y: 15, width: 300, height: 25)
            
            detailLbl.text = "运营商：Starhub\n适用客户：中国移动客户（无需开通漫游）\n支持网络：3G网络\n运营商网络名称：52505/Starhub 3G"
            detailLbl.frame = CGRect(x: titleLbl.x, y: titleLbl.frame.maxY + 15, width: padView.width - 50, height: UILabel.getHeight(padView.width, detailLbl.text!, UIFont.systemFont(ofSize: 13)))
        }
    }

}




