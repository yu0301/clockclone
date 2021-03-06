//
//  LabelVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class LabelVC: UIViewController {
    
    var delegate:LabelTextDelegate?
    var editAlarmVC:EditAlarmVC!
    var textField: UITextField = {
        let textField = UITextField()
            textField.returnKeyType = .done
            textField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            textField.clearButtonMode = .whileEditing
        return textField
    }()

    func setTextFieldConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.055).isActive = true
    }
    
    //MARK:- Action
    override func viewDidLoad() {
        title = "標籤"
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(textField)
        setTextFieldConstraints()
        textField.text = editAlarmVC.label
        textField.becomeFirstResponder()
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.labelText(text: textField.text!)
    }
}

