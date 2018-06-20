//
//  DiagramView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class DiagramView: UIView {
    
    var backView: UIView!
    var business: Business!
    let lineW:CGFloat = 1
    let space: CGFloat = 10
    let blockW: CGFloat = 15
    let backW: CGFloat = 280
    let backH: CGFloat = 125
    let titles = ["正使用","停机","未知","陈默期","测试期"]
    let colors = [KColor(0, 179, 79, 1),
                  KColor(255, 36, 71, 1),
                  KColor(80, 83, 101, 1),
                  KColor(0, 154, 255, 1),
                  KColor(195, 211, 165, 1)]
    var sectorColors = [UIColor]()
    var startArr = [CGFloat]()
    var endArr = [CGFloat]()
    var valueArr = [CGFloat]()
 
    convenience init(frame: CGRect, business: Business) {
        self.init(frame: frame)
        backgroundColor = UIColor.white
        self.business = business
        setShadow()
        
        setUpData()
        
        setUpSubviews()
        
    }
    
    func setUpData() {
        valueArr = [CGFloat(business.inUse),CGFloat(business.outage),CGFloat(business.unknown),CGFloat(business.silent),CGFloat(business.test)]
        print(valueArr)
        for i in 0 ..< 5 {
            var temp: CGFloat = 0
           
            for j in 0 ..< i {
                
                temp += valueArr[j]/CGFloat(business.total)
            }
            
            startArr.append(temp)
        }
        
        endArr = startArr
        endArr.remove(at: 0)
        endArr.append(1)
        sectorColors = colors
        
        print(startArr, endArr)
        
        let lineAngle = lineW / (backH * .pi)
        
        var emptyIndexArr = [Int]()
        for i in 0 ..< startArr.count {
            
            if startArr[i] == endArr[i] {
                emptyIndexArr.append(i)
            }
        }
        emptyIndexArr.reverse()
        
        for index in emptyIndexArr {
            startArr.remove(at: index)
            endArr.remove(at: index)
            sectorColors.remove(at: index)
        }
        
        print(startArr, endArr)
        let totalRate = 1 - CGFloat(startArr.count) * lineAngle * 2
        
        for i in 0 ..< startArr.count {
            
            startArr[i] = startArr[i] * totalRate + lineAngle * (2 * CGFloat(i) + 1)
            
            endArr[i] = endArr[i] * totalRate + lineAngle * (2 * CGFloat(i) + 1)
 
        }
        
        print(startArr, endArr)
    }
    func setUpSubviews() {
        backView = UIView(frame: CGRect(x: width/2.0 - backW/2.0, y: height/2.0 - backH/2.0 - 10, width: backW, height: backH))
        addSubview(backView)
        
        drawDiagram()
        
        setUpLbls()
    }
    func setUpLbls() {
        let whiteV = UIView(frame: CGRect(x: backW/2.0, y: 0, width: backW/2.0, height: backH))
        backView.addSubview(whiteV)
        
        let headLbl = UILabel(frame: CGRect(x: backW/2.0 + 5, y: 0, width: backW/2.0 - space, height: 25), fontsize: 15)
        headLbl.setTextColors(["\(business.name)卡", "\(business.total)", "张"], [KColor(0, 0, 0, 0.8), UIColor.red, KColor(0, 0, 0, 0.8)])
        
        backView.addSubview(headLbl)
        
        for i in 0 ..< valueArr.count {
            let colorView = UIView(frame: CGRect(x: headLbl.x, y: headLbl.frame.maxY + (5 + blockW) * CGFloat(i), width: blockW, height: blockW))
            colorView.backgroundColor = colors[i]
            backView.addSubview(colorView)
            
            let titleLbl = UILabel(frame: CGRect(x: colorView.frame.maxX + 5, y: colorView.y, width: 150, height: colorView.height), color: headLbl.textColor, fontsize: 13, text: titles[i])
            backView.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: backW - 150, y: colorView.y, width: 140, height: colorView.height), color: KBlueColor, alignment: .right,fontsize: 13, text: "\(Int(valueArr[i]))")
            backView.addSubview(valueLbl)
        }
    }
    func drawDiagram() {
        
        for i in 0 ..< startArr.count {
            
            drawSector(startAngle: startArr[i] * .pi * 2 - .pi/2.0, endAngle: endArr[i] * .pi * 2 - .pi/2.0, radius: backH/2.0, color: sectorColors[i])
            
        }
        
        drawSector(startAngle: 0, endAngle: .pi * 2, radius: backH/2.0 - 30, color: UIColor.white)
    }
    
    func drawSector(startAngle:CGFloat, endAngle:CGFloat, radius:CGFloat, color:UIColor) {
        
        let sectorLayer = CAShapeLayer()
        sectorLayer.frame = CGRect(x: 0, y: 0, width: backH, height: backH)
        backView.layer.addSublayer(sectorLayer)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: backH/2.0, y: backH/2.0))
        path.addArc(withCenter: CGPoint(x: backH/2.0, y: backH/2.0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sectorLayer.path = path.cgPath
        sectorLayer.lineWidth = lineW
        sectorLayer.strokeColor = UIColor.white.cgColor
        sectorLayer.fillColor = color.cgColor
      
    }
}







