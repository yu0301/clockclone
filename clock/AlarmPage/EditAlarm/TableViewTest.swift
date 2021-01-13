//
//  TableViewTest.swift
//  clock
//
//  Created by 陳冠諭 on 2020/10/8.
//  Copyright © 2020 KuanYu. All rights reserved.
//
//
//import UIKit
//protocol PushNextPage {
//    func pushNextPage(vc: UIViewController)
//}
//
//class TableViewTest: UITableView {
//    var repeatStatusArray = [DataInfomation.DaysOfWeek]()
//    var edidtstyle:EditStyle!
//    
//    var myDelegate: PushNextPage!
//    var sectionNumber = 1
//    var label:String!
//    var ringTone:String!
//    var repeatStatus:String!
//    let sections = EditAlarmSection.allCases
//    let rows = EditAlarmRow.allCases
//    let editAlarmTableView:UITableView = {
//        let editAlarmTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//        editAlarmTableView.backgroundColor = .yellow
//        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
//        editAlarmTableView.rowHeight = fullScreenSize.height * 0.056
//        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        editAlarmTableView.isScrollEnabled = false
//        editAlarmTableView.tableFooterView = UIView()
//        return editAlarmTableView
//    }()
//     func cellLabelContent(index: Int) ->(String,String){
//        switch index {
//        case 0:
//            return ("重複",repeatStatus)
//        case 1:
//            return ("標籤",label)
//        case 2:
//            return ("提示聲",ringTone)
//        case 3:
//            return ("稍後提醒","")
//        default:
//            break
//        }
//        return ("","")
//    }
//    
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: CGRect(x: 100, y: 300, width: 300, height: 300), style: style)
//        editAlarmTableView.delegate = self
//        editAlarmTableView.dataSource = self
//        
//        switch edidtstyle {
//        case .add:
//            repeatStatus = "永不"
//            label = "鬧鐘"
//            ringTone = "雷達"
//        case .edit:
//            repeatStatus = "永不"
//            label = "鬧鐘"
//            ringTone = "雷達"
//        case .none:
//            print("error")
//        }
//        
//        addSubview(editAlarmTableView)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension TableViewTest: UITableViewDelegate,UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionNumber
//        
//    }
//    func sectionCount(editStyle: EditStyle)
//    {
//        sectionNumber = (editStyle == .add) ? 1 : 2
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let sectionView = UIView()
//        return sectionView
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return  section == 0 ? 4 : 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let editAlarmSection = sections[indexPath.section]
//        let editAlarmRow = rows[indexPath.row]
//        switch editAlarmSection{
//        case .空白:
//            switch editAlarmRow{
//            case .重複,.標籤,.提示聲:
//                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
//                cell.textLabel?.text = cellLabelContent(index: indexPath.row).0
//                cell.editAlarmCellLabel.text = cellLabelContent(index: indexPath.row).1
//                return cell
//                
//            //單獨放上switch
//            case .稍後提醒:
//                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
//                cell.textLabel?.text = cellLabelContent(index: indexPath.row).0
//                cell.accessoryView = cell.snoozeSwitch
//                return cell
//            }
//            
//        case .刪除鬧鐘:
//            switch indexPath.row{
//            case 0:
//                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
//                cell.setDeletecell()
//                return cell
//            default:
//                fatalError()
//            }
//        }
//    }
//    
//    //MARK: -跳轉頁面
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let editAlarmSection = sections[indexPath.section]
//        let editAlarmRow = rows[indexPath.row]
//        
//        switch editAlarmSection{
//        case .空白:
//            switch editAlarmRow{
//            case .重複:
//                let vc1 = RepeatVC()
//                vc1.delegate = self
//                vc1.editAlarmVC = EditAlarmVC()
//                myDelegate.pushNextPage(vc: vc1)
////                navigationController?.pushViewController(vc1, animated: true)
//            case .標籤:
//                let vc2 = LabelVC()
//                vc2.delegate = self
//                vc2.editAlarmVC = EditAlarmVC()
////                editAlarmVC.navigationController?.pushViewController(vc2, animated: true)
//            case .提示聲:
//                let vc3 = RingToneVC()
//                vc3.delegate = self
//                vc3.editAlarmVC = EditAlarmVC()
////                navigationController?.pushViewController(vc3, animated: true)
//            case .稍後提醒:
//                break
//            }
//            
//        case .刪除鬧鐘:
//            switch indexPath.row{
//            case 0:
////                alarmVC.alarmArray.remove(at: indexPath.row)
////                UserDefaultData.saveData(alarmArray: alarmVC.alarmArray)
////                alarmVC.alarmTableView.reloadData()
////                dismiss(animated: true, completion: nil)
//                break
//            default:
//                fatalError()
//            }
//        }
//    }
//}
//
////MARK: -接收repeat
//extension TableViewTest:SetRepeatDelegate{
//    func setRepeat (days: [DataInfomation.DaysOfWeek]){
//        repeatStatusArray = days
//        repeatStatus = days.uiString
//    }
//}
//
////MARK: -接收textField
//extension TableViewTest:LabelTextDelegate{
//    func labelText(controller: UIViewController) {
//        if let pushController = controller as? LabelVC {
//            self.label = pushController.textField.text!
//        }
//    }
//}
//
////MARK: -接收ringtone
//extension TableViewTest:SetRingToneDelegate{
//    func setRingTone(index:Int){
//        ringTone = DataInfomation.ringTone[index]
//    }
//}
