
import UIKit
 
class MyCardsVc: BaseVc, UITableViewDataSource, UITableViewDelegate {
    
    let offsetH:CGFloat = 200
    
    var tableView: UITableView!
    
    var headerView: UIView!
    
    var footerView: UIView!
    
    var cardList = [Card]()
    
    var cardNoList = [Int]()
    
    var headLbl: UILabel!
    
    var pageLbl: UILabel!
    
    weak var pageBtn1: UIButton!
    
    weak var pageBtn2: UIButton!
    
    var page: Int = 1
    
    var pageView: UIView!
    
    
    let cellTitleArr = ["白马号码","所属商户","ICCID","总流量","状态","到期时间"]
    
    let proportionArr: [CGFloat] = [0.2, 0.15, 0.2, 0.1, 0.1, 0.25]
    let cellTitleXArr: [CGFloat] = [0, 0.2, 0.35, 0.55, 0.65, 0.75]
    
    func setUpData() {
        for _ in 0 ..< 10 {
            let card = Card()
            card.bema_no = "sdfasdf"
            card.supplier = "得意"
            card.iccid = "23423423"
            card.flow = 50
            card.status = "正常"
            card.real_expire = "2018-09-01"
            cardList.append(card)
            
            
        }
        
        for _ in 0 ..< 100 {
            cardNoList.append(24)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Mystring("卡片列表")
        setUpData()
        setUpTableView()
        refreshData()
    }
    
    func refreshData() {
        APITool.request(target: .cardListInquiry(pageNumber: 1, pageSize: 10), success: { (result) in
            print("结果", result)
             
        }) { (error) in
            print(error)
        }
    }
    
    func setUpPageView() {
        pageView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 40))
        view.backgroundColor = KBackgroundColor
        footerView.addSubview(pageView)
        
        for i in 0 ..< 2 {
            let pageBtn = UIButton(frame: CGRect(x: KWidth/2.0 - 140 + 200 * CGFloat(i), y: 0, width: 80, height: 40), title: ["上一页","下一页"][i], titleColor: KColor(0, 0, 0, 0.8), fontsize: 16, target:self, selector: #selector(pageBtnClicked(_ :)))
            pageView.addSubview(pageBtn)
            if i == 0 {
                pageBtn1 = pageBtn
            }else {
                pageBtn2 = pageBtn
            }
        }
        
        
        pageLbl = UILabel(frame: CGRect(x: KWidth/2.0 - 60, y: 0, width: 120, height: 40), color: UIColor.red, fontsize: 14)
        pageView.addSubview(pageLbl)
        
        refreshPages()
    }
    
    func setUpHeadLbl() {
        
        headLbl = UILabel.init(frame: CGRect(x: 10, y: 10, width: 300, height: 25), color: KColor(0, 0, 0, 0.8), fontsize:18, text: "总计：\(cardNoList.count)张")
        headerView.addSubview(headLbl)
        
    }
    func setUpTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - KStatusBarH - (navigationController?.navigationBar.height)!), style:.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 1
        tableView.estimatedSectionFooterHeight = 1
        tableView.backgroundColor = KBackgroundColor
        tableView.rowHeight = 40
        tableView.contentInset = UIEdgeInsetsMake(0, 0, max(555 - tableView.height + offsetH, offsetH), 0)
        view.addSubview(tableView)
        
        setUpHeaderView()
        
        setUpFooterView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func setUpFooterView() {
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 200))
        footerView.backgroundColor = KBackgroundColor
        tableView.tableFooterView = footerView
        setUpPageView()
       
    }
    
    func setUpHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 95))
        headerView.backgroundColor = KBackgroundColor
        tableView.tableHeaderView = headerView
        
        setUpHeadLbl()
        
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: headLbl.frame.maxY + 25, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: cellTitleArr[i])
            headerView.addSubview(lbl)
        }
    }
    
    
    func refreshPages() {
        let totalPage = cardNoList.count%10 == 0 ? (cardNoList.count/10) : cardNoList.count/10 + 1
        if page <= 1 {
            pageBtn1.isEnabled = false
            pageBtn1.setTitleColor(UIColor.gray, for: .normal)
        }else {
            pageBtn1.isEnabled = true
            pageBtn1.setTitleColor(UIColor.black, for: .normal)
        }
        
        if page >= totalPage {
            pageBtn2.isEnabled = false
            pageBtn2.setTitleColor(UIColor.gray, for: .normal)
        }else {
            pageBtn2.isEnabled = true
            pageBtn2.setTitleColor(UIColor.black, for: .normal)
        }
        
        pageLbl.text = "共\(totalPage)页，第\(page)页"
        
        if cardNoList.count == 0 {
            pageLbl.text = "共0页"
        }
        pageLbl.textAlignment = .center
    }
    
    @objc func pageBtnClicked(_ btn:UIButton) {
        ProgressHUD.show(withStatus: "刷新中...")
        
        
    }
    func dealWithResult(chargeList: [NSDictionary]) {
        var cards = [Card]()
        for dic in chargeList {
            if let card = Card.deserialize(from: dic) {
                cards.append(card)
            }
        }
        self.cardList = cards
        tableView.reloadData()
    }
    
    
    //    MARK: tableviewdelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardManagementVc = CardManagementVc()
        cardManagementVc.card = cardList[indexPath.row]
        navigationController?.pushViewController(cardManagementVc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let card = cardList[indexPath.row]
     
        let txtArr = [card.bema_no,card.supplier,card.iccid, "\(card.flow)", "\(card.status)",NSString.yyyyMMddFromString(card.real_expire)]
        for i in 0 ..< 6 {
            let lbl = UILabel(frame: CGRect(x: cellTitleXArr[i] * view.width, y: 0, width: proportionArr[i] * view.width, height: tableView.rowHeight), color: KColor(0, 0, 0, 0.8), alignment: .center, fontsize: 12, text: txtArr[i])
            lbl.numberOfLines = 0
            cell.contentView.addSubview(lbl)
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

}
    






