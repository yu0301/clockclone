//
//  Protocol.swift
//  clock
//
//  Created by 陳冠諭 on 2020/10/9.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation

protocol PassAlarmArray {
    func passAlarmArray(data:[AlarmData])
}

protocol SetRepeatDelegate {
    func setRepeat (days: [DataInfomation.DaysOfWeek])
}

protocol LabelTextDelegate {
    func labelText(text: String)
}

protocol SetRingToneDelegate{
    func setRingTone(index:Int)
}
