//
//  Alarm.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit


class Alarm: UIViewController, EditAlarmVCDelegate{
    
    
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
    
    //MARK: -接收資料
    func passAlarmData(controller: UIViewController) {
        if let pushController = controller as? EditAlarmVC{
            guard let backClockInDate = pushController.savedClock else { return  }
            let backClockInString = dateToDateString(backClockInDate)
            print(backClockInString)
        }
    }
    
    
//    var times:Array<String>?
//    var alarm:Array<String>?
    var savedClock = ["1:12","2:12","3:12"]
    var alarm = ["ppp","ooo","qqq"]
    var alarmNavigationBar = UINavigationBar()
    var alarmNavigationItem = UINavigationItem(title: "Alarm")
    var alarmTableView = UITableView()
    
    
    //
    func setAlarmNavigationBar(){
        alarmNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmNavigationBar.setItems([alarmNavigationItem], animated: false)
        view.addSubview(alarmNavigationBar)
    }
    
    //set alarmTableView
    func setAlarmTableView(){
        alarmTableView.frame = CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height)
        alarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmTableView.register(AlarmCell.self, forCellReuseIdentifier: "Cell")
        alarmTableView.rowHeight = 80
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        alarmTableView.allowsSelection = false
         alarmTableView.allowsSelectionDuringEditing = true
        view.addSubview(alarmTableView)
    }
    
    //set alarm
    func setAlarmController(){
        self.tabBarItem.image = UIImage(systemName: "alarm.fill")
        self.tabBarItem.title = "Alarm"
    }
    
    //set left btn
    func setAlarmLeftBTN(){
        if alarmTableView.isEditing == false {
            alarmNavigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,target: self, action: #selector(doneTapped))
        }else{
            alarmNavigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(doneTapped))
        }
    }
    
    //set right btn
    func setAlarmRightBTN(){
        alarmNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func doneTapped(){
        if alarmTableView.isEditing == true {
            alarmTableView.setEditing(false, animated: true)
            setAlarmLeftBTN()
        }else{
            alarmTableView.setEditing(true, animated: true)
            setAlarmLeftBTN()
        }
    }
    
    @objc func addTapped(){
        //傳值
        let vc = EditAlarmVC()
        //點到某個值把已經存好的值傳過去
        present(vc, animated: true, completion: nil)
    }
    
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
        setAlarmController()
        setAlarmNavigationBarConstraints()
        setAlarmTableViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}

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
        cell.setAlarmLabel(indexpath: indexPath, data: alarm)
//        cell.setAlarmSwitch()
        cell.setClockLabelConstraints()
        cell.setAlarmLabelConstraints()
//        cell.setAlarmSwithConstraints()
        return cell
    }
    
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmTableView.beginUpdates()
            alarmTableView.deleteRows(at: [indexPath], with: .fade)
            savedClock.remove(at: indexPath.row)
            alarmTableView.endUpdates()
        }
    }
    
    //傳送資料
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTableView.allowsSelectionDuringEditing = true
        let vc = EditAlarmVC()
        vc.savedClock = stringConvertDate(string: savedClock[indexPath.row])
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}
