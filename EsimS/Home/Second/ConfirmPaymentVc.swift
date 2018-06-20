//
//  ConfirmPaymentVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/12.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
import SVProgressHUD
class ConfirmPaymentVc: BaseVc, PaymentResultViewDelegate {
    var paymentResultView: PaymentResultView!
    
    var month: Int = 0
     
    var sum: Double = 0
    
    var simList: [Any]!
    
    var order: Order!
      
    var scrollView: UIScrollView!
    
    var detailView: UIView!
    
    var detailCell1: UIView!
    
    var detailCell2: UIView!
    
    var detailCell3: UIView!
    
    var paymentView: UIView!
    
    weak var selectedMethodBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "确认付款"
        
        setUpScrollView()
        
    }
   
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = KBackgroundColor
        view.addSubview(scrollView)
        
        setUpDetailView()
        
        setUpPaymentView()
        
        setUpPayBtn()
    }
    
    func setUpDetailView() {
        detailView = UIView(frame: CGRect(x: 0, y: 20, width: KWidth, height: 100))
        detailView.backgroundColor = KBackgroundColor
        scrollView.addSubview(detailView)
        
        setUpDetailCell1()

        setUpDetailCell2()

        setUpDetailCell3()
        
    }
    
    func setUpDetailCell1() {
        detailCell1 = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 80))
        detailCell1.backgroundColor = UIColor.white
        detailView.addSubview(detailCell1)
        
        let titleTxt = ["订单号码:","交易类型:"]
        for i in 0 ..< 2 {
            
            let w = UILabel.getWidth(titleTxt[i], UIFont.systemFont(ofSize: 14, weight: .bold))
            
            let titleLbl = UILabel(frame: CGRect(x: 15, y: 15 + 30 * CGFloat(i), width: w, height: 20), color: UIColor.black, text: titleTxt[i])
            titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            detailCell1.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 10, y: titleLbl.y, width: 400, height: titleLbl.height), color: KColor(0, 0, 0, 0.8), fontsize: 14, text: [order.order_no,order.order_type][i])
            detailCell1.addSubview(valueLbl)
        }
        
    }
    func setUpDetailCell2() {
        detailCell2 = UIView(frame: CGRect(x: 0, y: detailCell1.frame.maxY + 1, width: KWidth, height: 80))
        detailCell2.backgroundColor = UIColor.white
        detailView.addSubview(detailCell2)
        
        let titleTxt = ["续费期限:","续卡总数:"]
        for i in 0 ..< 2 {
            
            let w = UILabel.getWidth(titleTxt[i], UIFont.systemFont(ofSize: 14, weight: .bold))
            
            let titleLbl = UILabel(frame: CGRect(x: 15, y: 15 + 30 * CGFloat(i), width: w, height: 20), color: UIColor.black, text: titleTxt[i])
            titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            detailCell2.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 10, y: titleLbl.y, width: 400, height: titleLbl.height), color: KColor(0, 0, 0, 0.8), fontsize: 14, text: ["\(month)个月","\(simList.count)张"][i])
            detailCell2.addSubview(valueLbl)
        }
    }
    func setUpDetailCell3() {
        
        detailCell3 = UIView(frame: CGRect(x: 0, y: detailCell2.frame.maxY + 1, width: KWidth, height: 50))
        detailCell3.backgroundColor = UIColor.white
        detailView.addSubview(detailCell3)
        
        let titleW = UILabel.getWidth("套餐明细:", UIFont.systemFont(ofSize: 14, weight: .bold))
        let titleLbl = UILabel(frame: CGRect(x: 15, y: 15, width: titleW, height: 20), color: UIColor.black, text: "套餐明细:")
        titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        detailCell3.addSubview(titleLbl)
        
        let xArr: [CGFloat] = [15, 150, 200, 280]
        let wArr: [CGFloat] = [135, 50, 80, 200]
        for i in 0 ..< order.packageSumList.count {
            let cell = UIView(frame: CGRect(x: 0, y: CGFloat(i) * 40 + titleLbl.frame.maxY + 10, width: KWidth, height: 30))
            
            detailCell3.addSubview(cell)
            
            let detail = order.packageSumList[i]
            
            let txtArr = ["\(detail.agent) \(detail.name)", "\(detail.count)张","单张\(detail.price)元","总计:¥\(detail.sum)"]
            for j in 0 ..< txtArr.count {

                let height = UILabel.getHeight(wArr[j], txtArr[j], UIFont.systemFont(ofSize: 12))
                
                let lbl = UILabel(frame: CGRect(x: xArr[j], y: 0, width: wArr[j], height: height), color: KColor(0, 0, 0, 0.8), fontsize: 12, text: txtArr[j])
                lbl.numberOfLines = 0
                cell.addSubview(lbl)
                
                if j == 2 {
                    detailCell3.height = cell.frame.maxY + 15
                }
            }
        }
        
        detailView.height = detailCell3.frame.maxY
        
    }
    func setUpPaymentView() {
        paymentView = UIView(frame: CGRect(x: 0, y: detailView.frame.maxY + 10, width: KWidth, height: 130))
        paymentView.backgroundColor = UIColor.white
        
        scrollView.addSubview(paymentView)
        
        let titleTxt = ["费用总计:","账户余额:","支付方式:"]
        for i in 0 ..< 3 {
            
            let w = UILabel.getWidth(titleTxt[i], UIFont.systemFont(ofSize: 14, weight: .bold))
            
            let titleLbl = UILabel(frame: CGRect(x: 15, y: 15 + 30 * CGFloat(i), width: w, height: 20), color: UIColor.black, text: titleTxt[i])
            titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            paymentView.addSubview(titleLbl)
            
            for detail in order.packageSumList {
                sum += detail.sum
            }
            
            let valueLbl = UILabel(frame: CGRect(x: titleLbl.frame.maxX + 10, y: titleLbl.y, width: 400, height: titleLbl.height), color: KColor(0, 0, 0, 0.8), fontsize: 14, text: ["¥\(sum)","¥\(order.balance)", ""][i])
            paymentView.addSubview(valueLbl)
            
            
            if i == 2 {
                for j in 0 ..< 2 {
                    let methodBtn = UIButton(frame: CGRect(x: valueLbl.x + 5 + 100 * CGFloat(j), y: valueLbl.y - 5, width: 80, height: 30), title: ["余额支付","对公转账"][j], titleColor: [UIColor.red, UIColor.black][j], backgroundColor: [UIColor.white, KBackgroundColor][j], fontsize: 14, target: self, selector: #selector(methodBtn(_:)))
                    methodBtn.layer.borderWidth = 0.5
                    methodBtn.layer.borderColor = [UIColor.red, KColor(0, 0, 0, 0.3)][j].cgColor
                    
                    methodBtn.tag = 500 + j
                    paymentView.addSubview(methodBtn)
                    if j == 0 {
                        selectedMethodBtn = methodBtn
                    }
                }
            }
        }
        
        
        
    }
    @objc func methodBtn(_ btn: UIButton) {
        selectedMethodBtn.backgroundColor = KBackgroundColor
        selectedMethodBtn.layer.borderColor = KColor(0, 0, 0, 0.3).cgColor
        selectedMethodBtn.setTitleColor(UIColor.black, for: .normal)
        
        
        selectedMethodBtn = btn
        
        selectedMethodBtn.backgroundColor = UIColor.clear
        selectedMethodBtn.layer.borderColor = UIColor.red.cgColor
        selectedMethodBtn.setTitleColor(UIColor.red, for: .normal)
        
    }
    func setUpPayBtn() {
        let payBtn = UIButton(frame: CGRect(x: 20, y: paymentView.frame.maxY + 30, width: KWidth - 40, height: 40), title: "确认支付", titleColor: UIColor.white, backgroundColor: KBlueColor, fontsize: 14, target: self, selector: #selector(payBtnClicked))
        
        scrollView.contentSize = CGSize(width: KWidth, height: payBtn.frame.maxY + 50)
        scrollView.addSubview(payBtn)
    }
    
    @objc func payBtnClicked() {
        
        if order.balance < sum && selectedMethodBtn.tag == 500  {
            print("怎么回事\(order.balance)， \(sum)")
            SVProgressHUD.showError(withStatus: "余额不足")
            return
        }
        
        SVProgressHUD.show(withStatus: "支付中...")
        APITool.request(target: .confirmOrder(simNoList: simList, sim_type: 1, month: month, order_no: order.order_no, sum_fee: sum, pay_type: selectedMethodBtn.tag - 499, pay_status: true), success: { [weak self] (result) in
            print("结果DSA",result)
            
            
        }) { (error) in
            print(error)
            
        }
        
        paymentResultView = PaymentResultView(frame: UIScreen.main.bounds, result: .success)
        paymentResultView.showView()
        paymentResultView.delegate = self
        
    }
    
    func paymentResultViewClicked(_ result: KPaymentResult) {
        switch result {
        case .success:
            paymentResultView.hideView()
            navigationController?.popToRootViewController(animated: true)
            break
        case .failure:
            paymentResultView.hideView()
            break
        }
    }
}





