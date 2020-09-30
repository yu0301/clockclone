//
//  DateRepeat.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/28.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation

enum DateRepeat{
    
    
    enum DaysOfWeek: String,CaseIterable {
        case 星期日, 星期一, 星期二, 星期三, 星期四, 星期五, 星期六
    }
    
    enum repeatAdditional {
        case Never, Everday, Weekend, Weekday
        var destription: String {
            switch self {
            case .Never: return "永不"
            case .Everday: return "每天"
            case .Weekend: return "週末"
            case .Weekday: return "平日"
            }
        }
    }
}


//當array的型別等於DateRepeat.DaysOfWeek時，則有此extension內的功能
//讀取裡頭變數時，會根據array中的元素進行switch case 執行相對對應的動作
extension Array where Element == DateRepeat.DaysOfWeek {
    
    var uiString:String {
        switch self {
        case []:
            return DateRepeat.repeatAdditional.Never.destription
        case [.星期日, .星期一, .星期二, .星期三, .星期四, .星期五, .星期六]:
            return DateRepeat.repeatAdditional.Everday.destription
        case [.星期一, .星期二, .星期三, .星期四, .星期五]:
            return DateRepeat.repeatAdditional.Weekday.destription
        case [.星期日,.星期六]:
            return DateRepeat.repeatAdditional.Weekend.destription
        default:
            return map{ $0.rawValue.suffix(1) }.reduce("") { (blank,day ) in
                "\(blank)週\(day) "}
        }
    }
    
    var uiStringMain:String{
        switch self {
        case []:
            return ""
        case [.星期日, .星期一, .星期二, .星期三, .星期四, .星期五, .星期六]:
            return DateRepeat.repeatAdditional.Everday.destription
        case [.星期一, .星期二, .星期三, .星期四, .星期五]:
            return "，每個\(DateRepeat.repeatAdditional.Weekday.destription)"
        case [.星期日,.星期六]:
            return "，每個\(DateRepeat.repeatAdditional.Weekend.destription)"
        default:
            return ", \(uiString)"
        }
    }
}
