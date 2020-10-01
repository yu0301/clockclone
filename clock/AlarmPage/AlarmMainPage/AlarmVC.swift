//
//  Alarm.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//
import UIKit
class AlarmViewController: UIViewController{

    //MARK: -設定區
    let alarmNavigationBar = UINavigationBar()
    let alarmTableView = UITableView()
    var editStyle:EditStyle?
    var indexPath: IndexPath?
    var alarmArray = [AlarmData]()
    
    func setAlarmNavigationBar(){
        view.addSubview(alarmNavigationBar)
    }

    func setAlarmTableView(){
        alarmTableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        alarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmTableView.register(AlarmCell.self, forCellReuseIdentifier: "Cell")
        alarmTableView.rowHeight = fullScreenSize.height * 0.1
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
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編輯", style: .done, target: self, action: #selector(doneTapped))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(doneTapped))
        }
    }
    
    func setAlarmRightBTN(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
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
        if alarmTableView.isEditing == true {
            alarmTableView.setEditing(false, animated: true)
            setAlarmLeftBTN()
        }
        let vc = EditAlarmVC()
        let navVC = UINavigationController(rootViewController: vc)
        vc.alarmVC = self
        editStyle = .add
        vc.editStyle = editStyle
        DataInfomation.editAlarmCellContent[1].1.removeAll()
       present(navVC, animated: true)
    }
    
    @objc func cancelTapped(){
        dismiss(animated: true, completion: nil)
    }
    
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
        alarmArray = UserDefaultData.loadData()
        setUI()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - tableview delegate
extension AlarmViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = alarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlarmCell
        cell.editingAccessoryView = cell.tailImageView
        cell.alarmLabel.text = alarmArray[indexPath.row].time
        cell.statusLabel.text = alarmArray[indexPath.row].status
        cell.repeatLabel.text = alarmArray[indexPath.row].repeatStatus.uiStringMain
        cell.alarmSwitch.isOn = alarmArray[indexPath.row].isOn
        return cell
    }
    
    
    
    
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmArray.remove(at: indexPath.row)
            UserDefaultData.saveData(alarmArray: alarmArray)
            alarmTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: -edit mode
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTableView.allowsSelectionDuringEditing = true
        let vc = EditAlarmVC()
        let navVC = UINavigationController(rootViewController: vc)
        vc.alarmVC = self
        vc.editStyle = .edit
        vc.indexPath = indexPath
        vc.isOn = alarmArray[indexPath.row].isOn
        vc.alarmDatePicker.date = stringConvertDate(string:  alarmArray[indexPath.row].time)
        if alarmTableView.isEditing == true {
            alarmTableView.setEditing(false, animated: true)
            setAlarmLeftBTN()
        }
        present(navVC, animated: true, completion: nil)
    }
}

//儲存完後 開啟狀態
