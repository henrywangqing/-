//
//  AddRenewListVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/2.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
 
class AddRenewListVc: BaseVc, UITextViewDelegate, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    
    var textView: UITextView!
    
    var textViewback: UIView!
    
    var seg: UISegmentedControl!
    
    var placeHolderLbl: UILabel!
    
    weak var subtractBtn: UIButton!
    
    weak var plusBtn: UIButton!
    
    var periodView: UIView!
    
    var periodTf: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Mystring("续费")
        
        setUpScrollView()
    
    }
    
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.width, height: scrollView.height + 200)
        view.addSubview(scrollView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(tap)
        
        setUpSeg()
        
        setUpTextView()
        
        setUpPeriodView()
        
        setUpAddBtn()
    }
    
    func setUpAddBtn() {
        let addBtn = UIButton(frame: CGRect(x: 20, y: periodView.frame.maxY + 20, width: KWidth - 40, height: 40), title: Mystring("添加到续费"), imageName: "", titleColor: UIColor.white, backgroundColor: KBlueColor, fontsize: 15, target: self, selector: #selector(addBtnClicked))
        scrollView.addSubview(addBtn)
    }
    @objc func addBtnClicked() {
        
        if Int(periodTf.text!) == nil || textView.text.count == 0 {
            return
        }
 
        ProgressHUD.show(withStatus: "添加中...")
            
        APITool.request(target: .getRenewedCardInfo(simNoList: NSString.arrayFromString(textView.text), sim_type: seg.selectedSegmentIndex + 1, month: Int(periodTf.text!)!, pageNumber: 1, pageSize: 10), success: { [weak self] (result) in
            print("结果",result)
            
            if let resultDict = result as? NSDictionary,
               let simList = resultDict["simList"] as? [Int],
               let chargeList = resultDict["chargeList"] as? [NSDictionary] {
                var cards = [Card]()
                for dic in chargeList {
                    if let card = Card.deserialize(from: dic) {
                        cards.append(card)
                    }
                }
                
                let showRenewListVc = ShowRenewListVc()
                showRenewListVc.simList = simList
                showRenewListVc.chargeList = cards
                showRenewListVc.month = Int(self!.periodTf.text!)!
            self!.navigationController?.pushViewController(showRenewListVc, animated: true)
                
            }
             
        }) { (error) in
            print(error)
            
        }
        

    }
    
    @objc func scrollViewTapped() {
        view.endEditing(true)
    }
    func setUpTextView() {
        textViewback = UIView(frame: CGRect(x: 20, y: seg.frame.maxY + 10, width: scrollView.width - 40, height: 200))
        textViewback.backgroundColor = UIColor.white
        textViewback.setShadow()
        scrollView.addSubview(textViewback)
        
        textView = UITextView(frame: textViewback.bounds)
        textView.backgroundColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.delegate = self
        textViewback.addSubview(textView)
        
        placeHolderLbl = UILabel(frame: CGRect(x: 5, y: 7, width: 200, height: 20))
        placeHolderLbl.textColor = KColor(0, 0, 0, 0.4)
        placeHolderLbl.text = Mystring("请用空格或逗号隔开")
        placeHolderLbl.font = UIFont.systemFont(ofSize: 14)
        textViewback.addSubview(placeHolderLbl)
        
    }
    
    
    func setUpSeg() {
        seg = UISegmentedControl(items: [Mystring("ICCID"), Mystring("IMSI")])
        seg.frame = CGRect(x: scrollView.width/2.0 - 100, y: 10, width: 200, height: 30)
        seg.selectedSegmentIndex = 0
        seg.tintColor = UIColor.red
        scrollView.addSubview(seg)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLbl.isHidden = textView.text.count == 0 ? false : true
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            view.endEditing(true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    func setUpPeriodView() {
        periodView = UIView(frame: CGRect(x: 0, y: textViewback.frame.maxY + 20, width: KWidth, height: 50))
        scrollView.addSubview(periodView)
        
        let titleLbl = UILabel(frame: CGRect(x: 40, y: 10, width: 200, height: 30), color: KColor(0, 0, 0, 0.8), fontsize: 15, text: "续费期限（月）")
        periodView.addSubview(titleLbl)
        
        for i in 0 ..< 2 {
            let btn = UIButton(frame: CGRect(x: KWidth - 180 + CGFloat(i) * 100, y: 5, width: 40, height: 40), title: ["-", "+"][i], imageName: "", titleColor: KColor(0, 0, 0, 0.8), fontsize: 30, target: self, selector: #selector(periodBtnClicked(_:)))
            if i == 0 {
                subtractBtn = btn
                subtractBtn.setTitleColor(KColor(0, 0, 0, 0.4), for: .normal)
            }else {
                plusBtn = btn
            }
            periodView.addSubview(btn)
        }
        periodTf = UITextField(frame: CGRect(x: KWidth - 140, y: 10, width: 60, height: 30), color: KColor(0, 0, 0, 0.8), backgroundColor:KColor(0, 0, 0, 0.1), alignment: .center, fontsize: 18, text: "1")
        periodTf.keyboardType = .numberPad
        periodView.addSubview(periodTf)
        periodTf.addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    //    MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            if Int(periodTf.text!) == nil {
                periodTf.text = "1"
                subtractBtn.setTitleColor(KColor(0, 0, 0, 0.4), for: .normal)
                subtractBtn.isEnabled = false
            }else if Int(periodTf.text!)! <= 1 {
                subtractBtn.setTitleColor(KColor(0, 0, 0, 0.4), for: .normal)
                subtractBtn.isEnabled = false
            }else {
                subtractBtn.setTitleColor(KColor(0, 0, 0, 0.8), for: .normal)
                subtractBtn.isEnabled = true
            }
        }
    }
    
    //    MARK: textFieldDelegate
    
    @objc func periodBtnClicked(_ btn:UIButton) {
        
        if btn == subtractBtn {
            periodTf.text = "\(Int(periodTf.text!)! - 1)"
        }else {
            periodTf.text = "\(Int(periodTf.text!)! + 1)"
            
        }
    }
    
    deinit {
        periodTf.removeObserver(self, forKeyPath: "text")
    }
}




