//
//  RepeatVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class RepeatVC: UIViewController {
    //將拿到的array map，被點選到的會有一個bool
    //(,) tuple?
    var repeatArray: [(day:DataInfomation.DaysOfWeek,isSelected:Bool)] =
        DataInfomation.DaysOfWeek.allCases.map { (day: $0, isSelected: false)}
    var delegate: SetRepeatDelegate?
    var edidAlarmVC: EditAlarmVC!
    var dateTableView = UITableView()
    var index:Int!
    func setDateTableView(){
        dateTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        dateTableView.rowHeight = fullScreenSize.height * 0.056
        dateTableView.delegate = self
        dateTableView.dataSource = self
        dateTableView.tableFooterView = UIView()
        view.addSubview(dateTableView)
    }
    
    func setAlarmTableViewConstraints(){
        dateTableView.translatesAutoresizingMaskIntoConstraints = false
        dateTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dateTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dateTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        //把前一頁的日期傳過來
        let repeatStatusArray = edidAlarmVC.repeatStatusArray
        
        //將前一頁的日期與所有的日期進行比較，$0.day == 本地資料，day前頁資料，如果相同則得其index
        for day in repeatStatusArray{
            index = repeatArray.firstIndex(where: { $0.day == day
            })
        //再把該index對應的布林值變成true，就會打勾
        repeatArray[index].isSelected = true
        }
     
        title = "重複"
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setDateTableView()
        setAlarmTableViewConstraints()
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //把打勾的值挑出來，判定條件為true
        let repeatStatus = repeatArray.filter({ (day) -> Bool in
            day.isSelected
        })
        
        //打勾的值有兩個，一個是日期一個是有沒有被選，把日期當作參數傳出去
        delegate?.setRepeat(days: repeatStatus.map { $0.day})
        
    }
}

extension RepeatVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repeatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dateTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = repeatArray[indexPath.row].day.rawValue
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        //如果true則打勾，false則none
        cell.accessoryType = repeatArray[indexPath.row].isSelected ? .checkmark: .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = dateTableView.cellForRow(at: indexPath) {
            //點選動畫不立即生效
            dateTableView.deselectRow(at: indexPath, animated: true)
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                //被點到的row其isSelected為true
                repeatArray[indexPath.row].isSelected = true
            } else {
                cell.accessoryType = .none
                repeatArray[indexPath.row].isSelected = false
            }
        }
    }
}
