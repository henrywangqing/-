//
//  UILabelExtension.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(frame:CGRect, color:UIColor = UIColor.black, backgroundColor:UIColor = UIColor.clear, alignment:NSTextAlignment = .left, fontsize:CGFloat = 15, weight:UIFont.Weight = .regular, text:String = "") {
        self.init(frame: frame)
        self.textColor = color
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontsize, weight: weight)
        self.text = text
        self.backgroundColor = backgroundColor
 
        print(self)
    }
    
    class func getWidth(_ text: String, _ font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 0))
        lbl.text = text
        lbl.font = font
        lbl.sizeToFit()
        return lbl.width 
    }
    
    class func getHeight(_ width: CGFloat, _ text: String, _ font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        lbl.text = text
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl.height
        
    }
    
    func set(frame:CGRect, color:UIColor = UIColor.black, backgroundColor:UIColor = UIColor.clear, alignment:NSTextAlignment = .left, fontsize:CGFloat = 15, weight:UIFont.Weight = .regular, text:String = "") {
        self.frame = frame
        self.textColor = color
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontsize, weight: weight)
        self.text = text
        self.backgroundColor = backgroundColor
        
    }
    
    func setTextColors(_ texts:[String], _ colors:[UIColor]) {
        var str = ""
        for text in texts {
            str.append(text)
        }
        let totalTxt = str as NSString
        let attTxt = NSMutableAttributedString.init(string: str)
       
        for i in 0 ..< texts.count {
            
            attTxt.addAttribute(.foregroundColor, value: colors[i], range: totalTxt.range(of: texts[i]))
        }  
        
        self.attributedText = attTxt
        
    }
    
    func setTextFonts(_ texts:[String], _ fonts:[UIFont]) {
        var str = ""
        for text in texts {
            str.append(text)
        }
        let totalTxt = str as NSString
        let attTxt = NSMutableAttributedString.init(string: str)
        
        for i in 0 ..< texts.count {
            
            attTxt.addAttribute(.font, value: fonts[i], range: totalTxt.range(of: texts[i]))
        }
        
        self.attributedText = attTxt
        
    }
    
    
}
