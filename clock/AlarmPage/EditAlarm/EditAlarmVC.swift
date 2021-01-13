//
//  EditAlarmVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmVC: UIViewController{
    
    var editAlarmArray:[AlarmData]!
    var repeatStatusArray = [DataInfomation.DaysOfWeek]() 
    var indexPath: IndexPath!
    var label:String!
    var ringTone:String!
    var repeatStatus:String!
    var editStyle:EditStyle?
    let sections = EditAlarmSection.allCases
    let rows = EditAlarmRow.allCases
    //MARK:- UI設定
    let editAlarmTableView:UITableView = {
        let editAlarmTableView = UITableView()
        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
        editAlarmTableView.rowHeight = fullScreenY * 0.056
        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        editAlarmTableView.isScrollEnabled = false
        editAlarmTableView.tableFooterView = UIView()
        return editAlarmTableView
    }()
    
    let timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.text = "時間"
        return timeLabel
    }()
    
    let alarmDatePicker:UIDatePicker = {
        let alarmDatePicker = UIDatePicker()
        alarmDatePicker.locale = Locale(identifier: "en_GB")
        alarmDatePicker.datePickerMode = .time
        alarmDatePicker.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return alarmDatePicker
    }()
    
    func setEditAlarmLeftBTN(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancelTapped))
    }
    
    func setEditAlarmRightBTN(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "儲存", style: .done, target: self, action: #selector(saveSetClock))
    }
    
    @objc func cancelTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:-設定返回路徑並丟回需要的資料
    @objc func saveSetClock(){
        
        switch editStyle {
        case .add:
            let time = dateToDateString(alarmDatePicker.date)
            let alarm = AlarmData(time: time, status:label, repeatStatus: repeatStatusArray, ringTone: ringTone, isOn: true)
            editAlarmArray.append(alarm)
        case .edit:
            editAlarmArray[indexPath.row].time = dateToDateString(alarmDatePicker.date)
            editAlarmArray[indexPath.row].status = label
            editAlarmArray[indexPath.row].repeatStatus = repeatStatusArray
            editAlarmArray[indexPath.row].ringTone = ringTone
        case .none:
            print("error")
        }
        
        editAlarmArray.sort { $0.time.compare($1.time) == .orderedAscending
        }
        UserDefaultData.saveData(alarmArray: editAlarmArray )
        dismiss(animated: true, completion: nil)
    }
    
    func cellLabelContent(index: Int) ->(String,String){
        switch index {
        case 0:
            return ("重複",repeatStatus)
        case 1:
            return ("標籤",label)
        case 2:
            return ("提示聲",ringTone)
        case 3:
            return ("稍後提醒","")
        default:
            break
        }
        return ("","")
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
    
    
    func presetToOtherVC<VC:UIViewController>(vc:VC){
//        vc.delegate = self
//        vc.editAlarmVC = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Constriants
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
        alarmDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.17).isActive = true
    }
    
    func setAlarmTableViewConstraints(){
        editAlarmTableView.translatesAutoresizingMaskIntoConstraints = false
        editAlarmTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        editAlarmTableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.4).isActive = true
        editAlarmTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //MARK: -設定好的參數
    func setUI(){
        title = (editStyle == .edit) ? "編輯鬧鐘" : "加入鬧鐘" 
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.backButtonTitle = "返回"
        view.addSubview(editAlarmTableView)
        view.addSubview(timeLabel)
        view.addSubview(alarmDatePicker)
        editAlarmTableView.delegate = self
        editAlarmTableView.dataSource = self
        setEditAlarmLeftBTN()
        setEditAlarmRightBTN()
        setAlarmDatePickerConstraints()
        setTimeLabelConstraints()
        setAlarmTableViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch editStyle {
        case .add:
            repeatStatus = "永不"
            label = "鬧鐘"
            ringTone = "雷達"
        case.edit:
            alarmDatePicker.date = editAlarmArray[indexPath.row].TimeStringConvertDate()
            repeatStatus = editAlarmArray[indexPath.row].repeatStatus.uiString
            label = editAlarmArray[indexPath.row].status
            ringTone = editAlarmArray[indexPath.row].ringTone
        case .none:
            print("error")
        }
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editAlarmTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}

//MARK: -set tableviewcell
extension EditAlarmVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return editStyle == .add ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  section == 0 ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let editAlarmSection = sections[indexPath.section]
        let editAlarmRow = rows[indexPath.row]
        
        switch editAlarmSection{
        case .空白:
            switch editAlarmRow{
            case .重複,.標籤,.提示聲:
                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
                cell.textLabel?.text = cellLabelContent(index: indexPath.row).0
                cell.editAlarmCellLabel.text = cellLabelContent(index: indexPath.row).1
                return cell

            //單獨放上switch
            case .稍後提醒:
                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
                cell.textLabel?.text = cellLabelContent(index: indexPath.row).0
                cell.accessoryView = cell.snoozeSwitch
                return cell
            }
        case .刪除鬧鐘:
            switch indexPath.row{
            case 0:
                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
                cell.setDeletecell()
                return cell
            default:
                fatalError()
            }
        }
    }
    
    //MARK: -跳轉頁面
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editAlarmSection = sections[indexPath.section]
        let editAlarmRow = rows[indexPath.row]
        
        switch editAlarmSection{
        case .空白:
            switch editAlarmRow{
            case .重複:
                let vc1 = RepeatVC()
                vc1.delegate = self
                vc1.editAlarmVC = self
                navigationController?.pushViewController(vc1, animated: true)
            case .標籤:
                let vc2 = LabelVC()
                vc2.delegate = self
                vc2.editAlarmVC = self
                navigationController?.pushViewController(vc2, animated: true)
            case .提示聲:
                let vc3 = RingToneVC()
                vc3.delegate = self
                vc3.editAlarmVC = self
                navigationController?.pushViewController(vc3, animated: true)
            case .稍後提醒:
                break
            }
            
        case .刪除鬧鐘:
            switch indexPath.row{
            case 0:
                editAlarmArray.remove(at: indexPath.row)
                UserDefaultData.saveData(alarmArray: editAlarmArray)
                dismiss(animated: true, completion: nil)
            default:
                fatalError()
            }
        }
    }
}

//MARK: -接收repeat
extension EditAlarmVC:SetRepeatDelegate{
   
    func setRepeat (days: [DataInfomation.DaysOfWeek]){
        repeatStatusArray = days
        repeatStatus = days.uiString
    }
}

//MARK: -接收textField
extension EditAlarmVC:LabelTextDelegate{
    func labelText(text: String) {
        label = text
    }
}

//MARK: -接收ringtone
extension EditAlarmVC:SetRingToneDelegate{
    func setRingTone(index:Int){
        ringTone = DataInfomation.ringTone[index]
    }
}

//MARK:-接收主頁全部參數
extension EditAlarmVC:PassAlarmArray{
    func passAlarmArray(data: [AlarmData]) {
        editAlarmArray = data
    }
}

