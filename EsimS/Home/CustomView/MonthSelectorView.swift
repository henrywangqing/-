//
//  MonthSelectorView.swift
//  EsimS
//
//  Created by 王庆 on 2018/7/25.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class MonthSelectorView: UIView {

    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        backgroundColor = KColor(0, 0, 0, 0.3)
 
        setUpSubviews()
        
    }
    func setUpSubviews() {
        let lbl = UILabel()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




