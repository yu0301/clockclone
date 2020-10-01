//
//  DateRepeat.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/28.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation

enum DataInfomation{
    static var editAlarmCellTitle = ["重複","標籤","提示聲","稍後提醒"]
    static var editAlarmCellContent = [("",["永不","鬧鐘","雷達",""]),("",["佔位置用的^.<"])]
    static let ringTone = ["111","222","333","444","555","666","777","888","999"]
    
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
extension Array where Element == DataInfomation.DaysOfWeek {
    
    var uiString:String {
        switch self {
        case []:
            return DataInfomation.repeatAdditional.Never.destription
        case [.星期日, .星期一, .星期二, .星期三, .星期四, .星期五, .星期六]:
            return DataInfomation.repeatAdditional.Everday.destription
        case [.星期一, .星期二, .星期三, .星期四, .星期五]:
            return DataInfomation.repeatAdditional.Weekday.destription
        case [.星期日,.星期六]:
            return DataInfomation.repeatAdditional.Weekend.destription
        default:
            //map:取elements最後一個字
            let lastCharacter = map{ "週" + $0.rawValue.suffix(1) }
            //重新排列
            let sortedElement = lastCharacter.sorted { (day1, day2) -> Bool in
                return day1.compare(day2)  == ComparisonResult.orderedAscending
            }
            //變成字串
            let arrayToString = sortedElement.reduce("") { (blank,day ) in
                "\(blank)\(day) "}
            return arrayToString
        }
    }
    
    var uiStringMain:String{
        switch self {
        case []:
            return ""
        case [.星期日, .星期一, .星期二, .星期三, .星期四, .星期五, .星期六]:
            return DataInfomation.repeatAdditional.Everday.destription
        case [.星期一, .星期二, .星期三, .星期四, .星期五]:
            return "，每個\(DataInfomation.repeatAdditional.Weekday.destription)"
        case [.星期日,.星期六]:
            return "，每個\(DataInfomation.repeatAdditional.Weekend.destription)"
        default:
            return ", \(uiString)"
        }
    }
}