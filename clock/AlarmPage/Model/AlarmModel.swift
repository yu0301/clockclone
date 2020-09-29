//
//  AlarmModel.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/23.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation

struct AlarmData:Codable{
    var time:String
    var status:String
    var repeatStatus:[DateRepeat.DaysOfWeek]
}

enum EditStyle {
    case edit
    case add
}

extension DateRepeat.DaysOfWeek: Codable {
    
}
