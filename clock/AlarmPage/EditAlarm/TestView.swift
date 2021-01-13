//
//  TestView.swift
//  clock
//
//  Created by 陳冠諭 on 2020/10/8.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

//class TestView: UITableView {
//    var editAlarmVC = EditAlarmVC()
//    
//    let editAlarmTableView:UITableView = {
//        let editAlarmTableView = UITableView()
//        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
//        editAlarmTableView.rowHeight = fullScreenSize.height * 0.056
//        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        editAlarmTableView.isScrollEnabled = false
//        editAlarmTableView.tableFooterView = UIView()
//        return editAlarmTableView
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        self.backgroundColor = .white
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


//extension TestView: UITableViewDelegate,UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return editAlarmVC.editStyle == .add ? 1 : 2
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
//        let editAlarmSection = editAlarmVC.sections[indexPath.section]
//        let editAlarmRow = editAlarmVC.rows[indexPath.row]
//        
//        switch editAlarmSection{
//        case .空白:
//            switch editAlarmRow{
//            case .重複,.標籤,.提示聲:
//                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
//                cell.textLabel?.text = editAlarmVC.cellLabelContent(index: indexPath.row).0
//                cell.editAlarmCellLabel.text = editAlarmVC.cellLabelContent(index: indexPath.row).1
//                return cell
//                
//            //單獨放上switch
//            case .稍後提醒:
//                let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
//                cell.textLabel?.text = editAlarmVC.cellLabelContent(index: indexPath.row).0
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
//        let editAlarmSection = editAlarmVC.sections[indexPath.section]
//        let editAlarmRow = editAlarmVC.rows[indexPath.row]
//        
//        switch editAlarmSection{
//        case .空白:
//            switch editAlarmRow{
//            case .重複:
//                let vc1 = RepeatVC()
//                vc1.delegate = editAlarmVC
//                vc1.editAlarmVC = editAlarmVC
//                editAlarmVC.navigationController?.pushViewController(vc1, animated: true)
//            case .標籤:
//                let vc2 = LabelVC()
//                vc2.delegate = editAlarmVC
//                vc2.editAlarmVC = editAlarmVC
//                editAlarmVC.navigationController?.pushViewController(vc2, animated: true)
//            case .提示聲:
//                let vc3 = RingToneVC()
//                vc3.delegate = editAlarmVC
//                vc3.editAlarmVC = editAlarmVC
//                editAlarmVC.navigationController?.pushViewController(vc3, animated: true)
//            case .稍後提醒:
//                break
//            }
//            
//        case .刪除鬧鐘:
//            switch indexPath.row{
//            case 0:
//                editAlarmVC.alarmVC.alarmArray.remove(at: indexPath.row)
//                UserDefaultData.saveData(alarmArray: editAlarmVC.alarmVC.alarmArray)
//                editAlarmVC.alarmVC.alarmTableView.reloadData()
//                editAlarmVC.dismiss(animated: true, completion: nil)
//                
//            default:
//                fatalError()
//            }
//        }
//    }
//}
