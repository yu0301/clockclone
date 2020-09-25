//
//  LabelVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

protocol LabelTextDelegate {
    func LabelText(controller: UIViewController)
}

class LabelVC: UIViewController {
    var textField = UITextField()
    var delegate:LabelTextDelegate?
    var text:String?
    //need back navigation
    
    //MARK: -UI Set
    func setTextField(){
        textField.returnKeyType = .done
        textField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.text = text
        textField.delegate = self
        print(text)
        view.addSubview(textField)
    }
    
    func setTextFieldConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.08).isActive = true
    }
    
    //MARK:- Action
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setTextField()
        setTextFieldConstraints()
        textField.becomeFirstResponder()
        super.viewDidLoad()
    }
}

extension LabelVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.LabelText(controller: self)
        dismiss(animated: true, completion: nil)
        return true
    }
}


