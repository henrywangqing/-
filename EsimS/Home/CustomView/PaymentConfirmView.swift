//
//  PaymentConfirmView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

enum PaymentMethod {
    case weixin
    case alipay
}

protocol PaymentConfirmViewDelegate: NSObjectProtocol {
    func paymentConfirmViewWithPaymentMethod(_ method: PaymentMethod)
}

class PaymentConfirmView: UIView {
    let whiteViewH: CGFloat = 250
    var whiteView: UIView!
    weak var delegate: PaymentConfirmViewDelegate!

    init(frame: CGRect, money: Int) {
        super.init(frame: frame)
        setUpSubviews(money: money)
        
    }
    func setUpSubviews(money: Int) {
        backgroundColor = KColor(0, 0, 0, 0.3)
        
        whiteView = UIView(frame: CGRect(x: 0, y: KHeight, width: width, height: whiteViewH))
        whiteView.backgroundColor = UIColor.white
        addSubview(whiteView)
        
        let cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        cancelBtn.setTitleColor(KColor(0, 0, 0, 0.6), for: .normal)
        cancelBtn.setTitle(Mystring("取消"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        whiteView.addSubview(cancelBtn)
        
        let headLbl = UILabel(frame: CGRect(x: whiteView.width/2.0 - 100, y: 10, width: 200, height: 30))
        headLbl.font = UIFont.systemFont(ofSize: 20)
        headLbl.text = Mystring("确认付款")
        headLbl.textColor = UIColor.black
        headLbl.textAlignment = .center
        whiteView.addSubview(headLbl)
        
        let line1 = UIView(frame: CGRect(x: 0, y: 50, width: whiteView.width, height: 0.5))
        line1.backgroundColor = UIColor.lightGray
        whiteView.addSubview(line1)
        
        let amoutLbl = UILabel(frame: CGRect(x: 0, y: line1.frame.maxY + 30, width: whiteView.width, height: 50))
        
        amoutLbl.text = "¥\(String(format: "%.2f", CGFloat(money)))"
        amoutLbl.textColor = UIColor.black
        amoutLbl.font = UIFont.systemFont(ofSize: 40)
        amoutLbl.textAlignment = .center
        whiteView.addSubview(amoutLbl)
        
        for i in 0 ..< 2 {
            let cell = UIView(frame: CGRect(x: 0, y: whiteView.height - 50 * CGFloat(2 - i), width: whiteView.width, height: 50))
            whiteView.addSubview(cell)
            
            let line = UIView(frame: CGRect(x: 0, y: 0, width: whiteView.width, height: 0.5))
            line.backgroundColor = UIColor.lightGray
            cell.addSubview(line)
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 10, width: whiteView.width, height: 30))
            lbl.textColor = UIColor.black
            lbl.text = i == 0 ? "微信支付" : "支付宝支付"
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 20)
            cell.addSubview(lbl)
            
            let clearBtn = UIButton(frame: cell.bounds)
            clearBtn.tag = 600 + i
            clearBtn.addTarget(self, action: #selector(clearBtnClicked(_:)), for: .touchUpInside)
        }
    }
    @objc func clearBtnClicked(_ btn:UIButton) {
        
        switch btn.tag {
        case 600:
            break
        case 601:
            break
        default:
            break
        }
    }
    @objc func cancelBtnClicked() {
        hideView()
         
    }
    func hideView() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self!.whiteView.y += self!.whiteViewH
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    func showView() {
        UIApplication.shared.windows[0].addSubview(self)
       
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self!.whiteView.y -= self!.whiteViewH
        })
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}










