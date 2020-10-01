//
//  EditAlarmCell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmCell: UITableViewCell {
    
    let editAlarmCellLabel = UILabel()
    let snoozeSwitch = UISwitch()
    var trailImage = UIImageView(image: UIImage(named: "Forward_Filled"))
    //MARK: -Set UI
    func setEditAlarmCellLabel(){
        editAlarmCellLabel.backgroundColor = .clear
        editAlarmCellLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        editAlarmCellLabel.font = UIFont.systemFont(ofSize: 18)
        editAlarmCellLabel.adjustsFontSizeToFitWidth = true
        addSubview(editAlarmCellLabel)
    }
    
    func setCell(indexPath:IndexPath, title:[String]){
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        self.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.textLabel?.font = UIFont.systemFont(ofSize: 18)
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.text = title[indexPath.row]
    }
    
    func setDeletecell(){
        self.accessoryType = UITableViewCell.AccessoryType.none
        self.textLabel?.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        self.textLabel?.font = UIFont.systemFont(ofSize: 18)
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.text = "刪除鬧鐘"
        self.textLabel?.textAlignment = .center
    }
    
    func setSnoozeSwitch(){
       accessoryView = snoozeSwitch
    }
    //MARK:- Constraints
    func setEditAlarmCellLabelConstraints(){
        editAlarmCellLabel.translatesAutoresizingMaskIntoConstraints = false
        editAlarmCellLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        editAlarmCellLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        editAlarmCellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5).isActive = true
    }
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been imp;emented")
     }

}


