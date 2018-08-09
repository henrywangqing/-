//
//  FlowTableView.swift
//  EsimS
//
//  Created by 王庆 on 2018/6/15.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

protocol FlowTableViewDelegate: NSObjectProtocol {
    func flowTableViewHistoryBtnClicked()
}

class FlowTableView: UIView {
    weak var delegate: FlowTableViewDelegate?
    var backView: UIView!
    var card: Card!
    let sectorSpace: CGFloat = 0
    let lineW: CGFloat = 20
    let space: CGFloat = 10
    let blockW: CGFloat = 15
    let backW: CGFloat = 280
    let backH: CGFloat = 125
    let titles = ["总流量：","已 用：","剩 余："]
    
    let colors = [KColor(255, 36, 71, 1), KColor(0, 179, 79, 1)]
    var sectorColors = [UIColor]()
    var startArr = [CGFloat]()
    var endArr = [CGFloat]()
    var valueArr = [CGFloat]()
    
    var clearView: UIView!
    
    convenience init(frame: CGRect, card: Card) {
        self.init(frame: frame)
        backgroundColor = UIColor.white
        self.card = card
        
        setUpData()
        
        setUpSubviews()
        
    }
    
    func setUpData() {
        valueArr = [CGFloat(card.flow_used),CGFloat(card.flow_left)]
        
        for i in 0 ..< valueArr.count {
            var temp: CGFloat = 0
            
            for j in 0 ..< i {
                
                temp += valueArr[j]/CGFloat(card.flow)
            }
            
            startArr.append(temp)
        }
        
        endArr = startArr
        endArr.remove(at: 0)
        endArr.append(1)
        sectorColors = colors
        
        let spaceRate = sectorSpace / (backH * .pi)
        
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
        
        let totalRate = 1 - CGFloat(startArr.count) * spaceRate
        
        for i in 0 ..< startArr.count {
            
            startArr[i] = startArr[i] * totalRate + spaceRate/2 * (2 * CGFloat(i) + 1)
            
            endArr[i] = endArr[i] * totalRate + spaceRate/2 * (2 * CGFloat(i) + 1)
            
        }
        
    }
    func setUpSubviews() {
        backView = UIView(frame: CGRect(x: width/2.0 - backW/2.0, y: height/2.0 - backH/2.0, width: backW, height: backH))
        addSubview(backView)
        
        drawDiagram()
        
        setUpLbls()
        
        setAnimationCircle()
        
        setUpHistoryBtn()
    }
    func setUpHistoryBtn() {
        if card.flow > 0 {
            let historyBtn = UIButton(frame: CGRect(x: width - 70, y: 10, width: 60, height: 25), title: "历史用量", titleColor: KBlueColor, backgroundColor: UIColor.white, fontsize: 12, target: self, selector: #selector(historyBtnClicked))
            historyBtn.layer.cornerRadius = 10
            historyBtn.layer.borderWidth = 0.5
            historyBtn.layer.borderColor = KBlueColor.cgColor
            addSubview(historyBtn)
            historyBtn.isHidden = true
        }
    }
    
    @objc func historyBtnClicked() {
        if delegate != nil {
            delegate!.flowTableViewHistoryBtnClicked()
            
        }
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
        perform(#selector(removeMask), with: self, afterDelay: 1)
        sectorLayer.add(pathAnimation, forKey: "strokeEndAnimation")
        
    }
    @objc func removeMask() {
        clearView.removeFromSuperview()
    }
    
    func setUpLbls() {
        
        for i in 0 ..< valueArr.count + 1 {
            let colorView = UIView(frame: CGRect(x: backW/2 + 10, y: 30 + 20 * CGFloat(i), width: blockW, height: blockW))
            colorView.backgroundColor = i == 0 ? KColor(80, 83, 101, 1) : colors[i-1]
            backView.addSubview(colorView)
            
            let titleLbl = UILabel(frame: CGRect(x: colorView.frame.maxX + 5, y: colorView.y, width: 150, height: colorView.height), color: KColor(0, 0, 0, 0.8), fontsize: 13, text: titles[i])
            backView.addSubview(titleLbl)
            
            let valueLbl = UILabel(frame: CGRect(x: backW - 150, y: colorView.y, width: 140, height: colorView.height), color: KBlueColor, alignment: .right,fontsize: 13, text: i == 0 ? "\(card.flow)" : "\(valueArr[i-1])")
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







