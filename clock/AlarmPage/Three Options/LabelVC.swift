//
//  LabelVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class LabelVC: UIViewController {

    var textView = UITextView()
    
    func setTextView(){
        textView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(textView)
    }
    
    func setTextViewConstraints(){
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.08).isActive = true
    }
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setTextView()
        setTextViewConstraints()
        super.viewDidLoad()

       
    }
    

   

}
