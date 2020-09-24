//
//  EditAlarmCell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmCell: UITableViewCell {

    var editAlarmCellLabel = UILabel()
    
    //MARK: -Set UI
    func setEditAlarmCellLabel(indexpath:IndexPath, data:[String]){
        editAlarmCellLabel.backgroundColor = .clear
        editAlarmCellLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        editAlarmCellLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        editAlarmCellLabel.text = data[indexpath.row]
        addSubview(editAlarmCellLabel)
    }
    

    
    func setCell(indexpath:IndexPath, data:[String]){
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.textLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        self.textLabel?.text = data[indexpath.row]
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    
    }
    

     
    //MARK:- Constraints
    func setEditAlarmCellLabelConstraints(){
        editAlarmCellLabel.translatesAutoresizingMaskIntoConstraints = false
        editAlarmCellLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        editAlarmCellLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        editAlarmCellLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
        editAlarmCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been imp;emented")
     }

}


