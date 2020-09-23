//
//  EditAlarmCell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmCell: UITableViewCell {

    
    func setCell(indexpath:IndexPath, data:[String]){
//       self.adjustsFontSizeToFitWidth = true
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.textLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        self.textLabel?.text = data[indexpath.row]
    }
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been imp;emented")
     }
     
     
     

}
