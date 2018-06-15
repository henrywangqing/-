//
//  CardListVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/29.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class CardListVc: BaseVc, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButton()
        
        setUpTableView()
 
    }
    
    var tableView: UITableView!
    let titles = [["17084963411","17584963452","17484947761","17393496341"], ["03084963411","02084963452","05084947761","01393496341"]]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DataManager.save(currentSIMCard: titles[indexPath.section][indexPath.row])
        navigationController?.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "点击查看境内卡详情" : "点击查看境内卡详情"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        if DataManager.currentSIMCard() == titles[indexPath.section][indexPath.row] {
            cell.textLabel?.text = "\(titles[indexPath.section][indexPath.row])(当前选中)"
        }
        cell.detailTextLabel?.text = "联通制式"
        return cell
    }
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 40
        tableView.estimatedSectionFooterHeight = 1
        view.addSubview(tableView)
    }
    
    
    func setBarButton() {
        title = "我的SIM卡"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeCardListVc))
    }
    @objc func closeCardListVc() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
  
}





