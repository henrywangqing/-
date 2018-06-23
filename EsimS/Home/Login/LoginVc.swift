//
//  LoginVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
import CryptoSwift

class LoginVc: BaseVc, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    weak var accountTf: UITextField!
    weak var pwdTf: UITextField!
    weak var loginLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        setUpTableView()
    }
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 30
        tableView.estimatedSectionFooterHeight = 1
        view.addSubview(tableView)
        
        setUpTableFooterView()
        
    }
//    MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1, loginLbl.textColor == KBlueColor {
            loginBtnClicked()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        if indexPath.section == 0 {
            cell.selectionStyle = .none
            cell.textLabel?.text = ["账户","密码"][indexPath.row]
            let x = 40.0 + UILabel.getWidth(["账户","密码"][indexPath.row], UIFont.systemFont(ofSize: 17))
            let tf = UITextField(frame: CGRect(x: x, y: 0, width: KWidth - x - 20,
                                               height: tableView.rowHeight),
                                 fontsize: 17, placeholder: ["邮箱或手机号","密码"][indexPath.row])
            tf.delegate = self
            tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            cell.addSubview(tf)
            if indexPath.row == 0 {
                accountTf = tf
                accountTf.returnKeyType = .next
                accountTf.text = DataManager.accounts().count > 0 ? DataManager.accounts()[0].username: ""
            }else {
                pwdTf = tf
                pwdTf.returnKeyType = .done
            }
            
        }else {
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "登录"
            loginLbl = cell.textLabel
            cell.contentView.addSubview(loginLbl)
        }
        return cell
    }
    
    
//    MARK: uitextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountTf {
            pwdTf.becomeFirstResponder()
        }else {
            view.endEditing(true)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    @objc func textFieldEditingChanged() {
        if (accountTf.text?.count)! > 0, (pwdTf.text?.count)! > 0 {
            loginLbl.textColor = KBlueColor
        }else {
            loginLbl.textColor = UIColor.gray
        }
    }
    
    
    
    
    @objc func regBtnClicked() {
        navigationController?.pushViewController(RegVc(), animated: true)
    }
    @objc func forgetBtnClicked() {
        navigationController?.pushViewController(ForgetVc(), animated: true)
    }
    
    @objc func loginBtnClicked() {
        ProgressHUD.show(withStatus: "登录中...")
        
        APITool.request(target: .login(username: accountTf.text!, password: (pwdTf.text?.md5())!), success: { (result) in
            print("结果",result)
             
            ProgressHUD.showSuccess(withStatus: Mystring("登录成功"))
            if let resultDict = result as? NSDictionary,
                let account = Account.deserialize(from: resultDict) {
                
                DataManager.save(currentAccount: account)
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarVc()
                
            }
            
        }) { (error) in
            print(error)
            ProgressHUD.dismiss() 
        }
    }
    
    func setUpTableFooterView() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 80))
        tableView.tableFooterView = footer
        
        let regBtn = UIButton(frame: CGRect(x: 30, y: 0, width: UILabel.getWidth("注册账号", UIFont.systemFont(ofSize: 14)), height: 30),
                              title: "注册账号", imageName: "", titleColor: KBlueColor, fontsize: 14, target: self, selector: #selector(regBtnClicked))
        
        footer.addSubview(regBtn)
        
        let forgetBtnW = UILabel.getWidth("忘记密码？", UIFont.systemFont(ofSize: 14))
        let forgetBtn = UIButton(frame: CGRect(x: KWidth - 30 - forgetBtnW, y: regBtn.y, width: forgetBtnW, height: regBtn.height),
                              title: "忘记密码？", imageName: "", titleColor: KBlueColor, fontsize: 14, target: self, selector: #selector(forgetBtnClicked))
        footer.addSubview(forgetBtn)
     
    }
}





