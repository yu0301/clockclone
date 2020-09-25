//
//  EditAlarmVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//


//拿到暫存資料，確認後再回傳到前一頁的VC protocol這邊要拿到全部的東西再往回傳
protocol EditAlarmVCDelegate {
    func editAlarmData(controller: UIViewController,indexPath:IndexPath)
    func addAlarmData(controller: UIViewController, indexPath:IndexPath)
}
import UIKit

class EditAlarmVC: UIViewController {
    
    var editAlarmCellTitle = ["重複","標籤","提示聲","稍後提醒"]
    var editAlarmCellContent = ["每天","鬧鐘","雷達",""]
    var editAlarmNavigationBar = UINavigationBar()
    //判斷add or edit
    var editAlarmNavigationItem = UINavigationItem(title: "編輯鬧鐘")
    var editAlarmTableView = UITableView()
    var alarmDatePicker = UIDatePicker()
    var delegate:EditAlarmVCDelegate?
    var editStyle:EditStyle?
    var indexPath: IndexPath = [0,0]
    //MARK: -暫存區，接收改變後的參數，等確定要之後再丟給前面
    var alarmData:AlarmData?
    
    //MARK:- set UI
    func setEditAlarmNavigationBar(){
        editAlarmNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmNavigationBar.setItems([editAlarmNavigationItem], animated: false)
        view.addSubview(editAlarmNavigationBar)
    }
    
    func setEditAlarmTableView(){
        //        editAlarmTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
        editAlarmTableView.rowHeight = 50
        editAlarmTableView.delegate = self
        editAlarmTableView.dataSource = self
        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
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
    
    //MARK:-設定返回路徑並丟回需要的資料
    @objc func saveSetClock(){
        //            indexpath enum
        let vc = Alarm()
        vc.indexPath = indexPath
        alarmData = AlarmData(times: alarmDatePicker.date, label: "鬧鐘")
        if editStyle == .edit{
            delegate?.editAlarmData(controller: self,indexPath: indexPath)
        }else{
//            拿到此class的IndexPath
            delegate?.addAlarmData(controller: self,indexPath: indexPath)
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -Set clock
    func setAlarmDatePicker(){
        print(alarmDatePicker.date)
        alarmDatePicker.datePickerMode = .time
        alarmDatePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(alarmDatePicker)
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
        alarmDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.05).isActive = true
        alarmDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setAlarmTableViewConstraints(){
        editAlarmTableView.translatesAutoresizingMaskIntoConstraints = false
        editAlarmTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        editAlarmTableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.33).isActive = true
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
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
    }
}

//MARK: -set tableviewcell
extension EditAlarmVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editAlarmCellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
        cell.setCell(indexpath: indexPath, data: editAlarmCellTitle)
        cell.setEditAlarmCellLabel(indexpath: indexPath, data: editAlarmCellContent)
        cell.setEditAlarmCellLabelConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            editAlarmTableView.beginUpdates()
            editAlarmTableView.deleteRows(at: [indexPath], with: .fade)
            editAlarmCellTitle.remove(at: indexPath.row)
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
        vc2.text = editAlarmCellContent[indexPath.row]
        vc2.delegate = self
        if cellTitle == "重複"{
            present(vc1, animated: true, completion: nil)
        }else if cellTitle == "標籤"{
            present(vc2, animated: true, completion: nil)
        }else if cellTitle == "提示聲"{
            present(vc3, animated: true, completion: nil)
        }
    }
}
//MARK: -需要四個extension

//MARK: -接收labeltex資料
extension EditAlarmVC:LabelTextDelegate{
    func LabelText(controller: UIViewController) {
        if let pushController = controller as? LabelVC {
            let returnedText = pushController.textField.text
            editAlarmCellContent[1] = returnedText!
            editAlarmTableView.reloadData()
        }
    }
}
