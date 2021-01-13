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
    var repeatArray: [(day:DataInfomation.DaysOfWeek,isSelected:Bool)] =
        DataInfomation.DaysOfWeek.allCases.map { (day: $0, isSelected: false)}
    var delegate: SetRepeatDelegate?
    var editAlarmVC: EditAlarmVC!
    var index:Int!
    let dateTableView:UITableView = {
        let dateTableView = UITableView()
        dateTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        dateTableView.rowHeight = fullScreenY * 0.056
        dateTableView.tableFooterView = UIView()
        return dateTableView
    }()
 
    func setAlarmTableViewConstraints(){
        dateTableView.translatesAutoresizingMaskIntoConstraints = false
        dateTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dateTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dateTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setUI(){
        title = "重複"
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(dateTableView)
        setAlarmTableViewConstraints()
    }
    
    override func viewDidLoad() {
        let repeatStatusArray = editAlarmVC.repeatStatusArray
        //將前一頁的日期與所有的日期進行比較，$0.day == 本頁資料，day前頁資料，如果前頁資料的等於本業資料則得其index
        print(repeatStatusArray)
        for day in repeatStatusArray{
            index = repeatArray.firstIndex(where: { $0.day == day
            })
            repeatArray[index].isSelected = true
        }
        dateTableView.delegate = self
        dateTableView.dataSource = self
        setUI()
       
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
        print(repeatStatus.map { $0.day})
    }
}

//MARK: - tableview set
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
        cell.textLabel?.text = repeatArray[indexPath.row].day.rawValue
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.accessoryType = repeatArray[indexPath.row].isSelected ? .checkmark: .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repeatArray[indexPath.row].isSelected.toggle()
        dateTableView.reloadRows(at: [indexPath], with: .none)
    }
}

