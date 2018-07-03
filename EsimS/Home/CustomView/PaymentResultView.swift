//
//  PaymentResultView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

enum KPaymentState {
    case success
    case failure
}

protocol PaymentResultViewDelegate: NSObjectProtocol {
    func paymentResultViewClicked(_ paymentState: KPaymentState)
}

class PaymentResultView: UIView {
    let whiteViewH: CGFloat = 400
    var whiteView: UIView!
    var paymentState: KPaymentState!
    var resultString: String!
    weak var delegate: PaymentResultViewDelegate?
 
    init(frame: CGRect, paymentState: KPaymentState, resultString: String) {
        super.init(frame: frame)
        self.paymentState = paymentState
        self.resultString = resultString
        setUpSubviews(paymentState: paymentState)
    }
    
    func setUpSubviews(paymentState: KPaymentState) {
        backgroundColor = KColor(0, 0, 0, 0.3)
        
        whiteView = UIView(frame: CGRect(x: 20, y: -whiteViewH, width: KWidth - 40, height: whiteViewH))
        whiteView.backgroundColor = UIColor.white
        whiteView.setBorder(cornerRadius: 5)
        addSubview(whiteView)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: whiteViewH/2.0 - 50, width: whiteView.width, height: 25), color: UIColor.black, alignment: .center, fontsize: 16, text:  resultString)
       
        whiteView.addSubview(lbl)
        
        let btn = UIButton(frame: CGRect(x: whiteView.width/2.0 - 60, y: whiteViewH - 80, width: 120, height: 30), title: "确定", titleColor: KBlueColor, fontsize: 14, target: self, selector: #selector(btnClicked))
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = KBlueColor.cgColor
        whiteView.addSubview(btn)
    }
    @objc func btnClicked() {
        if delegate != nil {
            delegate!.paymentResultViewClicked(paymentState)
            
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
