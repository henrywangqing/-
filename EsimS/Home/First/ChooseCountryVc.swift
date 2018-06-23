//
//  ChooseCountryVc.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import UIKit

class ChooseCountryVc: BaseVc, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    let countries = [Country].deserialize(from: countryCodeJson)!
    var dataSource: [[Country]]!
    var titles = [String]()
    var searchBar: UISearchBar!
    var tableView: UITableView!
    @objc func setUpTableView() {
        dataSource = processData(countries as! [Country])
        
        tableView = UITableView(frame: CGRect(x: 0, y: searchBar.frame.maxY, width: KWidth, height: KHeight - searchBar.frame.maxY - KStatusBarH - (navigationController?.navigationBar.height)!))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: KWidth, height: 60))
        searchBar.placeholder = Mystring("搜索国家或地区")
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
//    MARK:uisearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource = processData(countries as! [Country])
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            showSearchResult()
        } else {
            dataSource = processData(countries as! [Country])
            tableView.reloadData()
        }
    }
//    MARK:uitableViewDelegate
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titles
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if titles.count > 0 {
            return titles[section]
        } else {
            return Mystring("最佳匹配")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchBar.isFirstResponder {
            view.endEditing(true)
        } else {
             
        }
    }
//    MARK:uitableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        }
        
        let country = dataSource[indexPath.section][indexPath.row]
        
        let pic = country.locale!
        
        cell.imageView?.image = UIImage(named: "countryPic.bundle/\(pic)")
        cell.textLabel?.text = country.zh!
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择目的地"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpSearchBar()
        setUpTableView()
    }
    func showSearchResult() {
       
        let resultArray = countries.filter { (item) -> Bool in
            return (item?.zh.contains(self.searchBar.text!))!
        }
        
        dataSource = [resultArray] as! [[Country]]
        titles.removeAll()
        tableView.reloadData()
    }

    
    
    func processData(_ source: [Country]) -> [[Country]]{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var result = [[Country]]()
        var tem = [Country]()
        titles.removeAll()
        
        for i in 0 ..< 26 {
            let letter = String(letters[letters.index(letters.startIndex, offsetBy: i)])
            
            for country in source {
                let firstLetter = getFirstLetterFromString(aString: country.zh!)
                if firstLetter == letter {
                    tem.append(country)
                    
                }
            }
            if tem.count > 0 {
                result.append(tem)
                tem.removeAll()
                titles.append(letter)
            }
        }
        return result
    }
    
    // MARK: - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
    private func getFirstLetterFromString(aString: String) -> (String) {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = String(strPinYin[..<strPinYin.index(strPinYin.startIndex, offsetBy:1)])
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    
    /// 多音字处理
    private func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }
    
}



