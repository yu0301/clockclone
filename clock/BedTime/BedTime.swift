//
//  BedTime.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class BedTime: UIViewController {
    
    
    
    func setBedTimeController(){
        self.tabBarItem.image = UIImage(systemName: "bed.double.fill")
        self.tabBarItem.title = "Bedtime"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBedTimeController()
        
    }
    
    
    
}
