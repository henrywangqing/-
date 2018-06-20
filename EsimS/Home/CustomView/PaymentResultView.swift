//
//  PaymentResultView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

enum KPaymentResult {
    case success
    case failure
}

protocol PaymentResultViewDelegate: NSObjectProtocol {
    func paymentResultViewClicked(_ result: KPaymentResult)
}

class PaymentResultView: UIView {
    let whiteViewH: CGFloat = KHeight - 100
    var whiteView: UIView!
    var result: KPaymentResult!
    weak var delegate: PaymentResultViewDelegate?
 
    init(frame: CGRect, result: KPaymentResult) {
        super.init(frame: frame)
        self.result = result
        setUpSubviews(result: result)
    }
    
    func setUpSubviews(result: KPaymentResult) {
        backgroundColor = KColor(0, 0, 0, 0.3)
        
        whiteView = UIView(frame: CGRect(x: 20, y: -whiteViewH, width: KWidth - 40, height: whiteViewH))
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 5
        addSubview(whiteView)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: whiteViewH/2.0 - 50, width: whiteView.width, height: 25), color: UIColor.black, alignment: .center, fontsize: 16, text:  result == .success ? "您已支付成功！" : "支付失败！")
        whiteView.addSubview(lbl)
        
        let btn = UIButton(frame: CGRect(x: whiteView.width/2.0 - 60, y: whiteViewH - 80, width: 120, height: 30), title: "确定", titleColor: KBlueColor, fontsize: 14, target: self, selector: #selector(btnClicked))
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = KBlueColor.cgColor
        whiteView.addSubview(btn)
    }
    @objc func btnClicked() {
        if delegate != nil {
            delegate!.paymentResultViewClicked(result)
            
        }
    }
  
    func hideView() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self!.whiteView.y = -self!.whiteViewH
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    func showView() {
        UIApplication.shared.windows[0].addSubview(self)
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self!.whiteView.y = KHeight/2.0 - self!.whiteViewH/2.0
        })
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
