//
//  AgreementVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/3.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit
 
class AgreementVc: BaseVc {
 
    var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户协议"
        setUpWebView()
        setBarButton()
    }
    func setBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    func setUpWebView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH -  (navigationController?.navigationBar.height)!))
        webView.backgroundColor = KBackgroundColor
        view.addSubview(webView)
        let filePath = Bundle.main.path(forResource: "Useragreement", ofType: "html")
        let request = URLRequest(url: URL(string: filePath!)!)
        webView.loadRequest(request)
    }
}
