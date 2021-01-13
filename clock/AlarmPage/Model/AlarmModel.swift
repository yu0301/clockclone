//
//  AlarmModel.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/23.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

struct AlarmData:Codable{
    var time:String
    var status:String
    var repeatStatus:[DataInfomation.DaysOfWeek]
    var ringTone:String
    var isOn:Bool
    
    func TimeStringConvertDate() -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: time)
        return date!
    }
}

enum EditStyle{
    case edit
    case add
}

enum EditAlarmSection:String,CaseIterable{
    case 空白,刪除鬧鐘
}

enum EditAlarmRow:String,CaseIterable{
    case 重複,標籤,提示聲,稍後提醒
}

let fullScreenY = UIScreen.main.bounds.maxY
let fullScreenX = UIScreen.main.bounds.maxX

extension DataInfomation.DaysOfWeek: Codable {
}
