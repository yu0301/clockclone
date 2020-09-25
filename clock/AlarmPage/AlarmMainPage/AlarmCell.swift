//
//  AlarmCell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class AlarmCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    //MARK: -Set Cell and Label
    var clockLabel = UILabel()
    var statusLabel = UILabel()
    var alarmSwitch = UISwitch()
    
    func setCell(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.accessoryView?.backgroundColor = #colorLiteral(red: 0.9809144139, green: 0.9119312763, blue: 0, alpha: 1)
        if Alarm().alarmTableView.isEditing == true {
            self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }else{
            self.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    func setClockLabel(indexpath: IndexPath,data:[String]){
        clockLabel.adjustsFontSizeToFitWidth = true
        clockLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        clockLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        clockLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        clockLabel.text = data[indexpath.row]
        addSubview(clockLabel)
    }
    
    func setAlarmLabel(indexpath:IndexPath, data:[String]){
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        statusLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        statusLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        statusLabel.text = data[indexpath.row]
        addSubview(statusLabel)
    }
    
    //MARK:- Switch
    func setAlarmSwitch(){
        alarmSwitch.frame = CGRect(x: 10, y: 10, width: 5, height: 5)
        alarmSwitch.addTarget(self, action: #selector(changeAlarmTextColor), for: .touchUpInside)
        addSubview(alarmSwitch)
    }
    @objc func changeAlarmTextColor(){
        if alarmSwitch.isOn == true{
            clockLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            statusLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            clockLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            statusLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    //MARK: -Constraints
    func setAlarmLabelConstraints(){
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 10).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
    }

    func setClockLabelConstraints(){
           clockLabel.translatesAutoresizingMaskIntoConstraints = false
           clockLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -15).isActive = true
           clockLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
           clockLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true

       }
    
    func setAlarmSwithConstraints(){
        alarmSwitch.translatesAutoresizingMaskIntoConstraints = false
        alarmSwitch.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        alarmSwitch.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
        alarmSwitch.trailingAnchor.constraint(equalTo:trailingAnchor,constant: 40).isActive = true
    }
}
