//
//  Timer.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class Timer: UIViewController {
    
    
    func setTimerController(){
        self.tabBarItem.image = UIImage(systemName: "timer")
        self.tabBarItem.title = "Timer"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTimerController()
    }
    
    
}
