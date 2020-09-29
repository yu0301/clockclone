//
//  EditAlarmVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmVC: UIViewController {
    var editAlarmCellTitle = ["重複","標籤","提示聲","稍後提醒"]
    var editAlarmCellContent = ["永不","鬧鐘","雷達",""]
    let editAlarmNavigationBar = UINavigationBar()
    let editAlarmNavigationItem = UINavigationItem()
    let editAlarmTableView = UITableView()
    let alarmDatePicker = UIDatePicker()
    var alarmVC:AlarmViewController!
    var repeatStatusArray =  [DateRepeat.DaysOfWeek]()
    var repeatStatus:String!
    var editStyle:EditStyle?
    var indexPath: IndexPath!
    let fullScreenY = UIScreen.main.bounds.maxY
    let fullScreenX = UIScreen.main.bounds.maxX
    let timeLabel = UILabel()
    //MARK: -暫存區，接收改變後的參數，等確定要之後再丟給前面
    var alarmData = [AlarmData]()
    
    //MARK:- set UI
    
    func setEditAlarmNavigationBar(){
        editAlarmNavigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmNavigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        editAlarmNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmNavigationBar.setItems([editAlarmNavigationItem], animated: false)
        if editStyle == .add {
            editAlarmNavigationItem.title = "加入鬧鐘"
        }else{
            editAlarmNavigationItem.title = "編輯鬧鐘"
        }
        view.addSubview(editAlarmNavigationBar)
    }
    func setTimeLabel(){
        timeLabel.backgroundColor = .clear
        timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        timeLabel.text = "時間"
        view.addSubview(timeLabel)
    }
    func setAlarmDatePicker(){
        alarmDatePicker.datePickerMode = .time
        alarmDatePicker.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        alarmDatePicker.inputView?.backgroundColor = .white
        alarmDatePicker.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(alarmDatePicker)
    }
    
    func setEditAlarmTableView(){
        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
        editAlarmTableView.rowHeight = 50
        editAlarmTableView.delegate = self
        editAlarmTableView.dataSource = self
        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        editAlarmTableView.tableFooterView = UIView()
        view.addSubview(editAlarmTableView)
    }
    
    func setEditAlarmLeftBTN(){
        editAlarmNavigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancelTapped))
    }
    
    func setEditAlarmRightBTN(){
        editAlarmNavigationItem.rightBarButtonItem = UIBarButtonItem(title: "儲存", style: .done, target: self, action: #selector(saveSetClock))
    }
    
    //MARK: -buttom action
    @objc func cancelTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:-設定返回路徑並丟回需要的資料
    @objc func saveSetClock(){
        switch editStyle {
        case .add:
            let alarm = AlarmData(time: dateToDateString(alarmDatePicker.date), status: editAlarmCellContent[1], repeatStatus:repeatStatusArray )
            print(repeatStatusArray)
            alarmVC?.alarmArray.append(alarm)
            
        case .edit:
            alarmVC.alarmArray[indexPath.row].time = dateToDateString(alarmDatePicker.date)
            alarmVC.alarmArray[indexPath.row].status = editAlarmCellContent[1]
            alarmVC.alarmArray[indexPath.row].repeatStatus = repeatStatusArray
        case .none:
            print("error")
        }
        
        // 抓出來比大小，越小越前面
        alarmVC.alarmArray.sort { $0.time.compare($1.time) == .orderedAscending
        }
        
        UserDefaultData.saveData(alarmArray: alarmVC.alarmArray )
        alarmVC?.alarmArray = UserDefaultData.loadData()
        alarmVC?.alarmTableView.reloadData()
        dismiss(animated: true, completion: nil)

    }
    
    //MARK: - Date to stiring
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
    
    func setTimeLabelConstraints(){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: fullScreenY * -0.28).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: fullScreenX * -0.3).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.05).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.3).isActive = true
    }
    
    func setAlarmDatePickerConstraints(){
        alarmDatePicker.translatesAutoresizingMaskIntoConstraints = false
        alarmDatePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: fullScreenY * -0.28).isActive = true
        alarmDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: fullScreenX * 0.32).isActive = true
        alarmDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.05).isActive = true
        alarmDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.22).isActive = true
    }
    
    func setAlarmTableViewConstraints(){
        editAlarmTableView.translatesAutoresizingMaskIntoConstraints = false
        editAlarmTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        editAlarmTableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.33).isActive = true
        editAlarmTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //MARK: -設定好的參數
    func setUI(){
        setEditAlarmNavigationBar()
        setAlarmDatePicker()
        setTimeLabel()
        setEditAlarmTableView()
        setEditAlarmLeftBTN()
        setEditAlarmRightBTN()
        setAlarmNavigationBarConstraints()
        setAlarmDatePickerConstraints()
        setTimeLabelConstraints()
        setAlarmTableViewConstraints()
    }
  
    
    
    override func viewDidLoad() {
        //1.title 2.titlecolor 3.left&right buttom
        

        alarmVC.alarmArray = UserDefaultData.loadData()
        switch editStyle {
        case .add:
            editAlarmCellContent[0] = "永不"
            editAlarmCellContent[1] = "鬧鐘"
            editAlarmCellContent[2] = "雷達"
        case.edit:
            editAlarmCellContent[0] = (alarmVC?.alarmArray[indexPath.row].repeatStatus.uiString)!
            editAlarmCellContent[1] = (alarmVC?.alarmArray[indexPath.row].status)!
            editAlarmCellContent[2] = "雷達"
            repeatStatusArray = (alarmVC?.alarmArray[indexPath.row].repeatStatus)!
        case .none:
            print("error")
        }
        

        editAlarmTableView.reloadData()
        setUI()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editAlarmTableView.reloadData()
    }
}

//MARK: -set tableviewcell
extension EditAlarmVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editAlarmCellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0...2:
            let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
            
            cell.setCell(indexPath:indexPath, title:editAlarmCellTitle)
            cell.setEditAlarmCellLabel()
            
            cell.editAlarmCellLabel.text = editAlarmCellContent[indexPath.row]
            cell.setEditAlarmCellLabelConstraints()
            return cell
            
        //單獨放上switch
        case 3:
            let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
            cell.setCell(indexPath:indexPath, title:editAlarmCellTitle)
            cell.setEditAlarmCellLabel()
            cell.setEditAlarmCellLabelConstraints()
            cell.setSnoozeSwitch()
            return cell
            
        default:
            fatalError()
        }
        
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
        vc1.delegate = self
        vc2.text = editAlarmCellContent[1]
        vc2.delegate = self
        if cellTitle == "重複"{
            present(vc1, animated: true, completion: nil)
            //            navigationController?.pushViewController(vc1, animated: true)
        }else if cellTitle == "標籤"{
            //            navigationController?.pushViewController(vc2, animated: true)
            present(vc2, animated: true, completion: nil)
        }else if cellTitle == "提示聲"{
            present(vc3, animated: true, completion: nil)
        }
    }
}

//MARK: -接收textField
extension EditAlarmVC:LabelTextDelegate{
    func labelText(controller: UIViewController) {
        if let pushController = controller as? LabelVC {
            let returnedText = pushController.textField.text
            editAlarmCellContent[1] = returnedText!
            editAlarmTableView.reloadData()
        }
    }
}

//MARK: -接收repeat
extension EditAlarmVC:SetRepeatDelegate{
    func setRepeat (days: [DateRepeat.DaysOfWeek]){
        //選完的日期經過"uiString"，return狀態
        repeatStatus = days.uiString
        editAlarmCellContent[0] = repeatStatus
        repeatStatusArray = days
        editAlarmTableView.reloadData()
    }
}
