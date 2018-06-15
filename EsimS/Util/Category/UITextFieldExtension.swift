//
//  UITextFieldExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/4.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

extension UITextField {
 
    convenience init(frame:CGRect, color:UIColor = UIColor.black, backgroundColor:UIColor = UIColor.clear, alignment:NSTextAlignment = .left, fontsize:CGFloat = 15, text:String = "", placeholder:String = "") {
        self.init(frame: frame)
        self.textColor = color
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontsize)
        self.text = text
        self.placeholder = placeholder
        self.backgroundColor = backgroundColor
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: KWidth, height: 44))
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(doneBtnClicked))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(doneBtnClicked))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)
        inputAccessoryView = toolbar
  
    }
    @objc func doneBtnClicked() {
        resignFirstResponder()
    }
    
}



