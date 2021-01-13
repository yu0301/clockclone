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
//        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addSubview(alarmLabel)
        addSubview(statusLabel)
        accessoryView = alarmSwitch
        alarmSwitch.addTarget(self, action: #selector(changeAlarmTextColor), for: .touchUpInside)
        setStatusLabelConstraints()
        setAlarmLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    //MARK: -Set Cell and Label
    var alarmVC:AlarmViewController!
    var isOn = true
    var cellIndexPath:IndexPath!
    var alarmSwitch = UISwitch()
    
    let alarmLabel:UILabel = {
        let alarmLabel = UILabel()
        alarmLabel.adjustsFontSizeToFitWidth = true
        alarmLabel.font = UIFont.systemFont(ofSize: 55 )
        return alarmLabel
    }()
    
    let statusLabel:UILabel = {
        let statusLabel = UILabel()
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.font = UIFont.systemFont(ofSize: 17 )
        statusLabel.numberOfLines = 2
        return statusLabel
    }()
    
    
    @objc func changeAlarmTextColor(){
        alarmVC.alarmArray[cellIndexPath.row].isOn = alarmSwitch.isOn
        UserDefaultData.saveData(alarmArray: alarmVC.alarmArray)
    }
    
    //MARK: -Constraints
    func setAlarmLabelConstraints(){
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmLabel.heightAnchor.constraint(equalTo:heightAnchor ,multiplier: fullScreenY * 0.0008).isActive = true
        alarmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: fullScreenX * 0.036).isActive = true
    }
    
    func setStatusLabelConstraints(){
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor,constant: fullScreenY * -0.0056).isActive = true
        statusLabel.widthAnchor.constraint(equalTo:widthAnchor ,multiplier: 1).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: fullScreenX * 0.036).isActive = true
    }
}
