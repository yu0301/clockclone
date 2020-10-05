//
//  Alarm.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//
import UIKit
class AlarmViewController: UIViewController{

    //MARK: - UI
    let viewForTableView = UIView()
    let alarmTableView = UITableView()
    var editStyle:EditStyle?
    var indexPath: IndexPath?
    var alarmArray = [AlarmData]()
    
    //MARK: - UI設定
    func setViewForTableView(){
        view.addSubview(viewForTableView)
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
        view.addSubview(alarmTableView)
    }
    
    func setAlarmLeftBTN(){
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
    
    //MARK: -Constraints區
    func setViewForTableViewConstraints(){
        viewForTableView.translatesAutoresizingMaskIntoConstraints = false
        viewForTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewForTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewForTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        viewForTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    func setAlarmTableViewConstraints(){
        alarmTableView.translatesAutoresizingMaskIntoConstraints = false
        alarmTableView.topAnchor.constraint(equalTo: viewForTableView.bottomAnchor).isActive = true
        alarmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        alarmTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        alarmTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: -設定好的參數
    func setUI(){
        setAlarmTableView()
        setViewForTableView()
        setAlarmLeftBTN()
        setAlarmRightBTN()
        setViewForTableViewConstraints()
        setAlarmTableViewConstraints()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmArray = UserDefaultData.loadData()
        setUI()
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
        cell.AlarmVC = self
        cell.editingAccessoryView = cell.tailImageView
        cell.alarmLabel.text = alarmArray[indexPath.row].time
        cell.statusLabel.text = alarmArray[indexPath.row].status
        cell.repeatLabel.text = alarmArray[indexPath.row].repeatStatus.uiStringMain
        cell.alarmSwitch.isOn = alarmArray[indexPath.row].isOn
        cell.setAlarmSwitch()
    
        //當alarmSwitch切換時，要改變本地的switch值
        //所以點擊alarmSwitch要可以改變switch
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmArray.remove(at: indexPath.row)
            UserDefaultData.saveData(alarmArray: alarmArray)
            alarmTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
    //MARK: -edit mode
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTableView.allowsSelectionDuringEditing = true
        let cell = alarmTableView.cellForRow(at: indexPath) as? AlarmCell
        
        let vc = EditAlarmVC()
        let navVC = UINavigationController(rootViewController: vc)
        vc.alarmVC = self
        vc.editStyle = .edit
        vc.indexPath = indexPath
        
        //將更新後的isOn傳到下一頁 OK
        //但是沒經過編輯狀態就無法改變
        vc.isOn = cell!.isOn
        vc.alarmDatePicker.date = stringConvertDate(string:  alarmArray[indexPath.row].time)
        if alarmTableView.isEditing == true {
            alarmTableView.setEditing(false, animated: true)
            setAlarmLeftBTN()
        }
        present(navVC, animated: true, completion: nil)
    }
}

//沒經過儲存的動作，重新開啟後不會改變switch結果
//switch改變 isOn沒改變
//ringtone 重複點會取消
