//
//  Alarm.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit
class Alarm: UIViewController{
    //  3.switch在編輯時無法消失 4.箭頭顏色
    //MARK: -string to date
    func stringConvertDate(string:String, dateFormat:String="HH:mm") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: string)
        return date!
    }
    //MARK: -date to string
    func dateToDateString(_ date:Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        let date = formatter.string(from: date)
        return date
    }
    //MARK: -設定區
    //    var savedClock:Array<String>?
    //    var alarm:Array<String>?
    var savedClock = ["1:12","2:12","3:12"]
    var alarmLabel = ["ppp","ooo","qqq"]
    var alarmNavigationBar = UINavigationBar()
    var alarmNavigationItem = UINavigationItem(title: "鬧鐘")
    var alarmTableView = UITableView()
    var editStyle:EditStyle?
    var indexPath: IndexPath?
    
    func setAlarmNavigationBar(){
        alarmNavigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmNavigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        alarmNavigationBar.setItems([alarmNavigationItem], animated: false)
        view.addSubview(alarmNavigationBar)
    }
    
    func setAlarmTableView(){
        alarmTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        alarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmTableView.register(AlarmCell.self, forCellReuseIdentifier: "Cell")
        alarmTableView.rowHeight = 80
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        alarmTableView.allowsSelection = false
        alarmTableView.allowsSelectionDuringEditing = true
        alarmTableView.tableFooterView = UIView()
        alarmTableView.separatorColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(alarmTableView)
    }
    
    func setAlarmLeftBTN(){
        //switch?
        if alarmTableView.isEditing == false {
            alarmNavigationItem.leftBarButtonItem = UIBarButtonItem(title: "編輯", style: .done, target: self, action:  #selector(editTapped))
        }else{
            alarmNavigationItem.leftBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action:  #selector(editTapped))
        }
    }
    
    func setAlarmRightBTN(){
        alarmNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    //MARK: -根據點前狀態改變點後狀態
    @objc func editTapped(){
        if alarmTableView.isEditing == true {
            alarmTableView.setEditing(false, animated: true)
            setAlarmLeftBTN()
        }else{
            alarmTableView.setEditing(true, animated: true)
            setAlarmLeftBTN()
        }
    }
    
    @objc func addTapped(){
        let vc = EditAlarmVC()
        editStyle = .add
        vc.editStyle = editStyle
        vc.delegate = self  //判斷路徑用
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: -Constriants區
    func setAlarmNavigationBarConstraints(){
        alarmNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        alarmNavigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        alarmNavigationBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alarmNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        alarmNavigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065).isActive = true
    }
    
    func setAlarmTableViewConstraints(){
        alarmTableView.translatesAutoresizingMaskIntoConstraints = false
        alarmTableView.topAnchor.constraint(equalTo: alarmNavigationBar.bottomAnchor).isActive = true
        alarmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        alarmTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        alarmTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setUI(){
        setAlarmTableView()
        setAlarmNavigationBar()
        setAlarmLeftBTN()
        setAlarmRightBTN()
        setAlarmNavigationBarConstraints()
        setAlarmTableViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setUI()
    }
}
//MARK: - tableview delegate
extension Alarm: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedClock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = alarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlarmCell
        cell.setCell()
        cell.setClockLabel(indexpath: indexPath, data: savedClock)
        cell.setAlarmLabel(indexpath: indexPath, data: alarmLabel)
        cell.setAlarmSwitch()
        cell.setClockLabelConstraints()
        cell.setAlarmLabelConstraints()
        cell.setAlarmSwithConstraints()
        return cell
    }
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedClock.remove(at: indexPath.row)
            alarmTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: -傳送資料 edit
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTableView.allowsSelectionDuringEditing = true
        let vc = EditAlarmVC()
        editStyle = .edit
        vc.editStyle = editStyle
        vc.indexPath = indexPath
        vc.alarmDatePicker.date = stringConvertDate(string: savedClock[indexPath.row])
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension Alarm:EditAlarmVCDelegate{
    
    //MARK: -路徑1 修改
    func editAlarmData(controller: UIViewController,indexPath:IndexPath) {
        if let pushController = controller as? EditAlarmVC{
            let backClockInDate = pushController.alarmData?.times
            let backClockInString = dateToDateString(backClockInDate!)
            let backAlarmLabel = pushController.alarmData?.label
            savedClock[indexPath.row] = backClockInString
            alarmLabel[indexPath.row] = backAlarmLabel!
            alarmTableView.reloadData()
        }
    }
    //MARK: -路徑2 新增
    func addAlarmData(controller: UIViewController,indexPath: IndexPath) {
        let lastInt = savedClock.count
        if let pushController = controller as? EditAlarmVC{
            let backClockInDate = pushController.alarmData?.times
            let backClockInString = dateToDateString(backClockInDate!)
            let backAlarmLabel = pushController.editAlarmCellContent[indexPath.row]
            savedClock.insert(backClockInString, at: lastInt)
            alarmLabel.insert(backAlarmLabel, at: lastInt)
            alarmTableView.reloadData()
        }
    }
}
