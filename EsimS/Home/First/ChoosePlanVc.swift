//
//  ChoosePlanVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class ChoosePlanVc: BaseVc, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var country: Country!
    var plans : [Plan]!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Mystring("选择套餐")
        
        var plan0 = Plan()
        plan0.country = country.zh
        plan0.name = "1日50M"
        plan0.network = "4G|"
        plan0.detail = "总计50M流量，超过后不能上网"
        plan0.discount = "5折"
        plan0.finalPrice = "2.5元"
        plan0.originalPrice = "5元"
        
        var plan = Plan()
        plan.country = country.zh
        plan.name = "1日不限量"
        plan.network = "4G|"
        plan.detail = "每天300M高速，超过后限速为128kbps"
        plan.discount = "6.9折"
        plan.finalPrice = "6.9元"
        plan.originalPrice = "10元"
        plans = [plan, plan]
        setUpTableView()
    }

    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        tableView.backgroundColor = KBackgroundColor
        tableView.tableFooterView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 50))
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 20
        tableView.sectionFooterHeight = 20
        tableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = KBackgroundColor
        }
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = KBackgroundColor
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planDetailVc = PlanDetailVc()
        planDetailVc.plan = plans[indexPath.row]
        navigationController?.pushViewController(planDetailVc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:PlanCell! = tableView.dequeueReusableCell(withIdentifier: "planCell") as? PlanCell

        if cell == nil {
            cell = PlanCell(style: .default, reuseIdentifier: "planCell")

        }
        cell.selectionStyle = .none
        cell.plan = plans[indexPath.row]
        return cell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}




