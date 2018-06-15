//
//  CardInquiry.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/6.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit


class CardInquiry: BaseVc, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
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
       
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        if indexPath.section == 0 {
            cell.selectionStyle = .none
            cell.textLabel?.text = "卡号/ICCID"
            let x = 40.0 + UILabel.getWidth("卡号/ICCID", UIFont.systemFont(ofSize: 17))
            inquiryTf = UITextField(frame: CGRect(x: x, y: 0, width: KWidth - x - 20,
                                               height: tableView.rowHeight),
                                 fontsize: 17, placeholder: "请输入卡号或ICCID")
            inquiryTf.delegate = self
            
            inquiryTf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            cell.addSubview(inquiryTf)
            
        }else {
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
            tabBarController?.present(UINavigationController(rootViewController: CardManagementVc()), animated: true, completion: nil)
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
