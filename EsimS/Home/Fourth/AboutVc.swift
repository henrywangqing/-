//
//  AboutVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/18.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class AboutVc: BaseVc {
    
    let txt = "白马物联作为一家eSIM和智能物联网技术服务商，应用物联网和人工智能技术，连接人、设备、内容和服务，赋能智能家居、智能公寓、智慧酒店、智慧养老等产业升级。 白马物联的核心技术在于有一套完整的智能物联网整体解决方案，专注于物联网协议打通、 设备控制和后端数据采集PaaS平台和人工智能技术的搭建，以及上游供应链产品的整合。"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "关于白马物联"
        
        setUpSubviews()
    }
    func setUpSubviews() {
        
        let lbl = UILabel(frame: CGRect(x: 20, y: 30, width: KWidth - 40, height: UILabel.getHeight(KWidth - 40, txt, UIFont.systemFont(ofSize: 14))), color: KColor(0, 0, 0, 0.8), fontsize: 14, text: txt)
        lbl.numberOfLines = 0
        view.addSubview(lbl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}













