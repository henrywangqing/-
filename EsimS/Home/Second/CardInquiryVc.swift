//
//  CardInquiryVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/6.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit


class CardInquiryVc: BaseVc, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    var inquiryTf: UITextField!
    
    weak var inquiryLbl: UILabel!
    
   

    override func viewDidLoad() {
        title = "单卡查询"
        setUpTableView()
    }
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        
        view.addSubview(tableView)
         
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell.selectionStyle = .none
            let titleW = UILabel.getWidth("ICCID/IMSI", UIFont.systemFont(ofSize: 17))
            let titleLbl = UILabel(frame: CGRect(x: 15, y: (tableView.rowHeight - 25)/2.0, width: titleW, height: 25),
                                   color: UIColor.black, fontsize: 17, text: "ICCID/IMSI")
            cell.contentView.addSubview(titleLbl)
            
            let inquiryTfX = 20 + titleLbl.frame.maxX
            inquiryTf = UITextField(frame: CGRect(x: inquiryTfX, y: 0, width: KWidth - inquiryTfX - 20,
                                               height: tableView.rowHeight),
                                 fontsize: 17, placeholder: "请输入ICCID/IMSI")
            inquiryTf.delegate = self
            
            inquiryTf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            cell.addSubview(inquiryTf)
            
        }else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.textLabel?.text = "查询"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.gray
            inquiryLbl = cell.textLabel
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1, inquiryLbl.textColor == KBlueColor {
            requestData()
        }
    }
    
    func requestData() {
        view.endEditing(true)
        ProgressHUD.showInfo(withStatus: "查询中...")
        APITool.request(target: .singleCardInquiry(sim_no: inquiryTf.text!), success: { [weak self] (result) in
            
            print("结果", result)
            if let resultDict = result as? [NSDictionary],
                let cards = [Card].deserialize(from: resultDict) {
                if cards.count > 0 {
                    self!.presentCardManagementVc(card: cards.first!!)
                }else {
                    ProgressHUD.showError(withStatus: "查不到信息")
                }
            }
            
        }) { (error) in
            print(error)
        }
    }
    func presentCardManagementVc(card: Card) {
        DispatchQueue.main.async { [weak self] in
            let vc = CardManagementVc()
            vc.card = card
            self!.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    @objc func textFieldEditingChanged() {
        if (inquiryTf.text?.count)! > 0 {
            inquiryLbl.textColor = KBlueColor
        }else {
            inquiryLbl.textColor = UIColor.gray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
       
}





