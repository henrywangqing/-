//
//  BaseVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class BaseVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        settings()
        
    }

    func settings() {
        view.backgroundColor = KBackgroundColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = KBackgroundColor
    }

}




