//
//  SecondVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/8.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class SecondVc: BaseVc {
    var scrollView: UIScrollView!

    var toolsView: UIView!
    
    var serviceView: UIView!
    
//    let toolsArr = ["单卡查询","卡片续费","卡片列表","我的订单","提交工单","常见问题","我的消息"]
    let toolsArr = ["单卡查询","卡片续费","卡片列表","我的订单"]
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        title = Mystring("服务")
        setUpScrollView()
        
    }
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (tabBarController?.tabBar.height)! - (navigationController?.navigationBar.height)!))
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        setUpToolsView()
    }
    
    
    func setUpToolsView() {
        let headLbl = UILabel(frame: CGRect(x: 10, y: 20, width: 300, height: 25))
        headLbl.font = UIFont.systemFont(ofSize: 18)
        headLbl.textColor = KColor(0, 0, 0, 0.8)
        headLbl.text = "实用工具"
        scrollView.addSubview(headLbl)
        
        toolsView = UIView(frame: CGRect(x: 10, y: headLbl.frame.maxY + 10, width: KWidth - 20, height: (KWidth - 20)/3 * CGFloat(toolsArr.count%3 == 0 ? toolsArr.count/3 : toolsArr.count/3 + 1)))
        toolsView.backgroundColor = UIColor.white
        toolsView.setShadow()
        scrollView.addSubview(toolsView)
        
        for i in 1 ..< 3 {
            let line = UIView(frame: CGRect(x: toolsView.width/3.0 * CGFloat(i), y: 5, width: 0.5, height: toolsView.height - 10))
            line.backgroundColor = UIColor.lightGray
            toolsView.addSubview(line)
        }
        for i in 1 ..< (toolsArr.count%3 == 0 ? toolsArr.count/3 : toolsArr.count/3 + 1) {
            let line = UIView(frame: CGRect(x: 5, y: toolsView.width/3.0 * CGFloat(i), width: toolsView.width - 10, height: 0.5))
            line.backgroundColor = UIColor.lightGray
            toolsView.addSubview(line)
        }
        
        
 
        for i in 0 ..< toolsArr.count {
            let cell = UIView(frame: CGRect(x: CGFloat(i%3) * toolsView.width/3.0, y: CGFloat(i/3) * toolsView.width/3.0, width: toolsView.width/3.0, height: toolsView.width/3.0))
            toolsView.addSubview(cell)
            
            let imageView = UIImageView(image: UIImage(named: toolsArr[i]))
            imageView.center = CGPoint(x: cell.width/2.0, y: cell.height/2.0 - 20)
            imageView.isUserInteractionEnabled = true
            cell.addSubview(imageView)
            let titleLbl = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 15, width: cell.width, height: 20))
            titleLbl.textColor = KColor(0, 0, 0, 0.8)
            titleLbl.font = UIFont.systemFont(ofSize: 14)
            titleLbl.textAlignment = .center
            titleLbl.text = toolsArr[i]
            cell.addSubview(titleLbl)
            
            let clearBtn = UIButton(frame: cell.bounds)
            clearBtn.addTarget(self, action: #selector(toolBtnClicked(_:)), for: .touchUpInside)
            clearBtn.tag = 500 + i
            cell.addSubview(clearBtn)
        }
    }
    
    @objc func toolBtnClicked(_ btn: UIButton) {
        switch btn.tag {
        case 500:
            navigationController?.pushViewController(CardInquiryVc(), animated: true)
            
            break
        case 501:
            navigationController?.pushViewController(AddRenewListVc(), animated: true)
             
            break
        case 502:
            navigationController?.pushViewController(MyCardsVc(), animated: true)
            break
        case 503:
            navigationController?.pushViewController(MyOrdersVc(), animated: true)
            break
        case 504:
            break
        case 505:
            break
        case 506:
            break
        default:
            break
        }
    }
}











