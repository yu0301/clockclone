//
//  UserDefault.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/28.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import Foundation
class UserDefaultData{
    static func saveData(alarmArray: [AlarmData]) {
        // Use PropertyListEncoder to convert Player into Data / NSData
        do {
            let alarms = try PropertyListEncoder().encode(alarmArray)
            UserDefaults.standard.set(alarms, forKey: "alarmsKey")
        } catch {
            print("Save data error.")
        }
    }
    
    static func loadData() -> [AlarmData] {
        guard let alarms = UserDefaults.standard.object(forKey: "alarmsKey") as? Data else { return [AlarmData]() }
        
        // Use PropertyListDecoder to convert Data into Player
        
        guard let alarmArray = (try? PropertyListDecoder().decode([AlarmData].self, from: alarms)) else {
            print("Load data error.")
            return [AlarmData]() }
        
        return alarmArray
    }
    
}
