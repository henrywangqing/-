//
//  RechargeVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/30.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class RechargeVc: BaseVc {
    let priceArr = ["10元","20元","50元","100元","300元","其他金额"]
    var scrollView: UIScrollView!
    var headerView: UIView!
    var contentView: UIView!
    var footerView: UIView!
    weak var selectedBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        title = Mystring("充值")
        
        setUpScrollView()
    }
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!))
        view.addSubview(scrollView)
        
        setUpHeaderView()
        setUpContentView()
        setUpFooterView()
    }
    func setUpHeaderView() {
        headerView = UIView(frame: CGRect(x: 10, y: 10, width: KWidth - 20, height: 50))
        headerView.layer.cornerRadius = 3
        headerView.backgroundColor = UIColor.white
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.gray.cgColor
        scrollView.addSubview(headerView)
        
        let numLbl = UILabel(frame: CGRect(x: 20, y: 15, width: 400, height: 20))
        numLbl.text = "号码：\(DataManager.currentSIMCard())"
        numLbl.textColor = KOrangeColor
        numLbl.font = UIFont.systemFont(ofSize: 20)
        headerView.addSubview(numLbl)
        
    }
    func setUpContentView() {
        contentView = UIView(frame: CGRect(x: headerView.x, y: headerView.frame.maxY + 20, width: headerView.width, height: 450))
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray.cgColor
        scrollView.addSubview(contentView)
        
        let btnW = (contentView.width - 80)/3.0
        for i in 0 ..< 6 {
            let btn = UIButton(frame: CGRect(x: 20 + CGFloat(i%3) * (btnW + 20), y: 40 + (40 + 15) * CGFloat(i/3), width: btnW, height: 40))
            btn.layer.cornerRadius = 3
            btn.layer.borderColor = KOrangeColor.cgColor
            btn.layer.borderWidth = 0.5
            btn.setTitle(priceArr[i], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(KOrangeColor, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(priceBtnClicked(_:)), for: .touchUpInside)
            btn.setBackgroundImage(UIColor.createImageWithColor(UIColor.white), for: .normal)
            btn.setBackgroundImage(UIColor.createImageWithColor(KColor(255, 236, 238, 0.6)), for: .selected)
            contentView.addSubview(btn)

            if i == 0 {
                btn.isSelected = true
                selectedBtn = btn
            }
            
        }
        
    }
    @objc func priceBtnClicked(_ btn:UIButton) {
        selectedBtn.isSelected = false
        selectedBtn = btn
        selectedBtn.isSelected = true
       
    }
    func setUpFooterView() {
        footerView = UIView(frame: CGRect(x: 0, y: KHeight - KStatusBarH - (navigationController?.navigationBar.height)! - (tabBarController?.tabBar.height)!, width: KWidth, height: 49))
        view.addSubview(footerView)
        footerView.backgroundColor = UIColor.white
        footerView.setShadow()
        
        let priceLbl = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
        priceLbl.setTextColors(["支付金额：", "100.00元"], [UIColor.black, KOrangeColor])
        priceLbl.font = UIFont.systemFont(ofSize: 20)
        footerView.addSubview(priceLbl)
        
        let buyBtn = UIButton(frame: CGRect(x: KWidth - 120, y: 0, width: 120, height: footerView.height))
        buyBtn.backgroundColor = KOrangeColor
        buyBtn.setTitle("立即购买", for: .normal)
        buyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        footerView.addSubview(buyBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}










