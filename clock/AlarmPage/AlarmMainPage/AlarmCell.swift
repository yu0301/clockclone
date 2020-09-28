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
        setCell()
        setAlarmLabel()
        setStatusLabel()
        setRepeatLabel()
        setAlarmSwitch()
        setStatusLabelConstraints()
        setAlarmLabelConstraints()
        setRepeatLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
        
    }
    
    //MARK: -Set Cell and Label
    var alarmLabel = UILabel()
    var statusLabel = UILabel()
    var repeatLabel = UILabel()
    var alarmSwitch = UISwitch()
    var tailImageView = UIImageView(image: UIImage(named: "Forward_Filled"))
    
    func setCell(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }
    
    func setAlarmLabel(){
        alarmLabel.adjustsFontSizeToFitWidth = true
        alarmLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        alarmLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alarmLabel.font = UIFont.boldSystemFont(ofSize: 30)
        alarmLabel.adjustsFontSizeToFitWidth = true
        addSubview(alarmLabel)
    }
    
    func setStatusLabel(){
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        statusLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        statusLabel.font = UIFont.boldSystemFont(ofSize: 18)
        statusLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(statusLabel)
    }
    
    func setRepeatLabel(){
        repeatLabel.adjustsFontSizeToFitWidth = true
        repeatLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        repeatLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        repeatLabel.font = UIFont.boldSystemFont(ofSize: 18)
        repeatLabel.adjustsFontSizeToFitWidth = true

        addSubview(repeatLabel)
    }
    
    //MARK:- Switch
    func setAlarmSwitch(){
        alarmSwitch.frame = CGRect(x: 10, y: 10, width: 5, height: 5)
        alarmSwitch.addTarget(self, action: #selector(changeAlarmTextColor), for: .touchUpInside)
        self.accessoryView = alarmSwitch
    }
    @objc func changeAlarmTextColor(){
        if alarmSwitch.isOn == true{
            alarmLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            statusLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            repeatLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            alarmLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            statusLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            repeatLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    //MARK: -Constraints
    func setAlarmLabelConstraints(){
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -15).isActive = true
        alarmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
    }

    func setStatusLabelConstraints(){
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 10).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
       }
    
    func setRepeatLabelConstraints(){
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 10).isActive = true
        repeatLabel.leadingAnchor.constraint(equalTo:statusLabel.trailingAnchor).isActive = true
       }
}
