//
//  Protocol.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/28.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation
protocol SetRepeatDelegate {
    func setRepeat (days: [DateRepeat.DaysOfWeek])
}

