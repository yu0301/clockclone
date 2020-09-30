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
    var repeatArray: [(day:DateRepeat.DaysOfWeek,isSelected:Bool)] =
        DateRepeat.DaysOfWeek.allCases.map { (day: $0, isSelected: false)}
    var delegate: SetRepeatDelegate?
    var editAlarmVC = EditAlarmVC()
    var date = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
    var dateTableView = UITableView()
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
        title = "重複"
        //要載入前面的repeatArray
//        let repeatArray = editAlarmVC.repeatStatusArray
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
        print(repeatStatus)
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
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dateTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = date[indexPath.row]
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
