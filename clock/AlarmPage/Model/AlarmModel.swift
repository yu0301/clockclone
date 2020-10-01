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
    //var ringTone:String
}

enum EditStyle {
    case edit
    case add
}

let fullScreenSize = UIScreen.main.bounds.size

enum ScreenSize {
    case width
    
    var value:CGFloat{
        switch self {
        case .width:
            return fullScreenSize.width
        }
    }
}

extension DataInfomation.DaysOfWeek: Codable {
    
}
