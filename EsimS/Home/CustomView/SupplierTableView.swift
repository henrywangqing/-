//
//  SupplierTableView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class SupplierTableView: UIView {
    
    var backView: UIView!
    var supplierTable: SupplierTable!
    let sectorSpace: CGFloat = 2
    let lineW: CGFloat = 30
    let space: CGFloat = 10
    let blockW: CGFloat = 15
    let backW: CGFloat = 280
    let backH: CGFloat = 125
    
    var colors = [KColor(0, 179, 79, 1),
                  KColor(255, 36, 71, 1),
                  KColor(80, 83, 101, 1),
                  KColor(0, 154, 255, 1),
                  KColor(195, 211, 165, 1),
                  UIColor.yellow]
    var sectorColors = [UIColor]()
    var startArr = [CGFloat]()
    var endArr = [CGFloat]()
    var valueArr = [CGFloat]()
    var titleArr = [String]()
    
    var clearView: UIView!
 
    convenience init(frame: CGRect, supplierTable: SupplierTable) {
        self.init(frame: frame)
        backgroundColor = UIColor.white
        self.supplierTable = supplierTable
        setShadow()
        
        setUpData()
        
        setUpSubviews()
        
    }
    
    func setUpData() {
        
        titleArr = NSString.arrayFromString(supplierTable.status_info)
        
        if titleArr.count == 0 {
            return
        }
        
        
         
        valueArr.append(CGFloat(supplierTable.s0))
        valueArr.append(CGFloat(supplierTable.s1))
        valueArr.append(CGFloat(supplierTable.s2))
        valueArr.append(CGFloat(supplierTable.s3))
        valueArr.append(CGFloat(supplierTable.s4))
        valueArr.append(CGFloat(supplierTable.s5))
        for _ in 0 ..< valueArr.count - titleArr.count {
            valueArr.remove(at: valueArr.count - 1)
            colors.remove(at: colors.count - 1)
        }
        
        for i in 0 ..< titleArr.count {
            var tempStart: CGFloat = 0
            var tempEnd: CGFloat = 0
            for j in 0 ..< i {
                
                tempStart += valueArr[j]/CGFloat(supplierTable.count)
            }
            
            startArr.append(tempStart)
            
            for j in 0 ... i {
                
                tempEnd += valueArr[j]/CGFloat(supplierTable.count)
            }
            
            endArr.append(tempEnd)
        }
        
        sectorColors = colors
        
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
        
        let spaceRate = sectorSpace / (backH * .pi)
        
        let totalRate = 1 - CGFloat(startArr.count) * spaceRate
        
        for i in 0 ..< startArr.count {
            
            startArr[i] = startArr[i] * totalRate + spaceRate/2 * (2 * CGFloat(i) + 1)
            
            endArr[i] = endArr[i] * totalRate + spaceRate/2 * (2 * CGFloat(i) + 1)
 
        }
         
    }
    func setUpSubviews() {
        backView = UIView(frame: CGRect(x: width/2.0 - backW/2.0, y: height/2.0 - backH/2.0 - 10, width: backW, height: backH))
        addSubview(backView)
        
        drawDiagram()
        
        setUpLbls()
        
        setAnimationCircle()
    }
    func setAnimationCircle() {
        clearView = UIView(frame: CGRect(x: 0, y: 0, width: backH, height: backH))
        backView.addSubview(clearView)
        
        let sectorLayer = CAShapeLayer()
        sectorLayer.frame = clearView.bounds
        clearView.layer.addSublayer(sectorLayer)

        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: backH/2.0, y: backH/2.0), radius: backH/2.0 - lineW/2.0, startAngle: 1.5 * .pi, endAngle: -.pi/2, clockwise: false)
        sectorLayer.path = path.cgPath
        sectorLayer.lineWidth = lineW + 2
        sectorLayer.strokeColor = UIColor.white.cgColor
        sectorLayer.fillColor = UIColor.clear.cgColor
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0
        pathAnimation.fromValue = 1
        pathAnimation.toValue   = 0
        perform(#selector(removeMask), with: self, afterDelay: 0.9)
        sectorLayer.add(pathAnimation, forKey: "strokeEndAnimation")
     
    }
    @objc func removeMask() {
        clearView.removeFromSuperview()
    }
    
    func setUpLbls() {
          
        let headLbl = UILabel(frame: CGRect(x: backW/2.0 + 5, y: 0, width: backW/2.0 - space, height: 25), fontsize: 15)
        headLbl.setTextColors(["\(supplierTable.name)卡", "\(supplierTable.count)", "张"], [KColor(0, 0, 0, 0.8), UIColor.red, KColor(0, 0, 0, 0.8)])
        
        backView.addSubview(headLbl)
        
        for i in 0 ..< valueArr.count {
            let colorView = UIView(frame: CGRect(x: headLbl.x, y: headLbl.frame.maxY + (5 + blockW) * CGFloat(i), width: blockW, height: blockW))
            colorView.backgroundColor = colors[i]
            backView.addSubview(colorView)
            
            let titleLbl = UILabel(frame: CGRect(x: colorView.frame.maxX + 5, y: colorView.y, width: 150, height: colorView.height), color: headLbl.textColor, fontsize: 13, text: titleArr[i])
            backView.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: backW - 150, y: colorView.y, width: 140, height: colorView.height), color: KBlueColor, alignment: .right,fontsize: 13, text: "\(Int(valueArr[i]))")
            backView.addSubview(valueLbl)
        }
    }
    func drawDiagram() {
        
        for i in 0 ..< startArr.count {
            
            drawSector(startAngle: startArr[i] * .pi * 2 - .pi/2.0, endAngle: endArr[i] * .pi * 2 - .pi/2.0, color: sectorColors[i])
            
        }
        
    }
    
    func drawSector(startAngle:CGFloat, endAngle:CGFloat, color:UIColor) {
        
        let sectorLayer = CAShapeLayer()
        sectorLayer.frame = CGRect(x: 0, y: 0, width: backH, height: backH)
        backView.layer.addSublayer(sectorLayer)
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: backH/2.0, y: backH/2.0), radius: backH/2.0 - lineW/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sectorLayer.path = path.cgPath
        sectorLayer.lineWidth = lineW
        sectorLayer.strokeColor = color.cgColor
        sectorLayer.fillColor = UIColor.clear.cgColor
      
    }
}







