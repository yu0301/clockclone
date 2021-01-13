//
//  Notification.swift
//  clock
//
//  Created by 陳冠諭 on 2020/10/5.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation
import UserNotifications

//class Notification{
//    
//    func createNotification(alarm: AlarmData){
//        let content = UNMutableNotificationContent()
//        
//        content.title = "Alarm Notification"
//        content.body = "time"
//        content.badge = 1
//        content.sound = UNNotificationSound.default
//        content.categoryIdentifier = "AlarmNotification"
//        
//        var identifier = "test ID"
//        var dateComponent = DateComponents()
//        
//        let hour = 16
//        let min = 04
//        
//        if alarm.repeatStatus.count == 0 {
//            dateComponent =  DateComponents(calendar: Calendar.current, hour: hour, minute: min, second: 0)
//        } else {
//            dateComponent =  DateComponents(calendar: Calendar.current, hour: hour, minute: min, second: 0)
//        }
//        
//        dateComponent等於觸發的日期
//        let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponent, repeats: true)
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
//                    print("鬧鐘開啟")
//                })
//    }
//    
//}
