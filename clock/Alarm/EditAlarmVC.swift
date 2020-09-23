//
//  EditAlarmVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

protocol EditAlarmVCDelegate {
    func passAlarmData(controller: UIViewController)
}

import UIKit

class EditAlarmVC: UIViewController {
    
    var data = ["Repeat","Label","Sound","Snooze"]
    var editAlarmNavigationBar = UINavigationBar()
    var editAlarmNavigationItem = UINavigationItem(title: "Edit Alarm")
    var editAlarmTableView = UITableView()
    var alarmDatePicker = UIDatePicker()
    var delegate:EditAlarmVCDelegate?
    //MARK: -等於前面傳來的資料
    var savedClock: Date?
    
    //MARK:- set UI
    func setEditAlarmNavigationBar(){
        editAlarmNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmNavigationBar.setItems([editAlarmNavigationItem], animated: false)
        view.addSubview(editAlarmNavigationBar)
    }
    
    func setEditAlarmTableView(){
        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
        editAlarmTableView.rowHeight = 50
        editAlarmTableView.delegate = self
        editAlarmTableView.dataSource = self
        view.addSubview(editAlarmTableView)
    }
    
    func setEditAlarmLeftBTN(){
        editAlarmNavigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,target: self, action: #selector(cancelTapped))
    }
    
    func setEditAlarmRightBTN(){
        editAlarmNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSetClock))
    }
    
    //MARK: -buttom action
    @objc func cancelTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveSetClock(){
        let newClock = alarmDatePicker.date
        savedClock = newClock
        delegate?.passAlarmData(controller: self)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -set clock
    func setAlarmDatePicker(){
        alarmDatePicker.datePickerMode = .time
        alarmDatePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(alarmDatePicker)
    }
    //當前時間，轉成string
    func dateToDateString(_ date:Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        let date = formatter.string(from: date)
        return date
    }
    
    //MARK:- Constriants
    func setAlarmNavigationBarConstraints(){
        editAlarmNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        editAlarmNavigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        editAlarmNavigationBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editAlarmNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        editAlarmNavigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065).isActive = true
    }
    
    func setAlarmDatePickerConstraints(){
        alarmDatePicker.translatesAutoresizingMaskIntoConstraints = false
        alarmDatePicker.topAnchor.constraint(equalTo: editAlarmNavigationBar.bottomAnchor,constant:0).isActive = true
        alarmDatePicker.bottomAnchor.constraint(equalTo: editAlarmTableView.topAnchor).isActive = true
        alarmDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    func setAlarmTableViewConstraints(){
        editAlarmTableView.translatesAutoresizingMaskIntoConstraints = false
        editAlarmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        editAlarmTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //MARK: -設定好的參數
    func setUI(){
        setEditAlarmNavigationBar()
        setAlarmDatePicker()
        setEditAlarmTableView()
        setEditAlarmLeftBTN()
        setEditAlarmRightBTN()
        setAlarmNavigationBarConstraints()
        setAlarmDatePickerConstraints()
        setAlarmTableViewConstraints()
    }
    
    override func viewDidLoad() {
        setUI()
        alarmDatePicker.date = savedClock!
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

//MARK: -set tableviewcell
extension EditAlarmVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
        cell.setCell(indexpath: indexPath, data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            editAlarmTableView.beginUpdates()
            editAlarmTableView.deleteRows(at: [indexPath], with: .fade)
            data.remove(at: indexPath.row)
            editAlarmTableView.endUpdates()
        }
    }
    
    //MARK: -跳轉頁面
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = editAlarmTableView.cellForRow(at: indexPath)!
        presentToOtherVC(cellTitle:(currentCell.textLabel?.text)!)
    }
    
    func presentToOtherVC(cellTitle:String){
        let vc1 = RepeatVC()
        let vc2 = LabelVC()
        let vc3 = SoundVC()
        if cellTitle == "Repeat"{
            present(vc1, animated: true, completion: nil)
        }else if cellTitle == "Label"{
            present(vc2, animated: true, completion: nil)
        }else if cellTitle == "Sound"{
            present(vc3, animated: true, completion: nil)
        }
    }
}

