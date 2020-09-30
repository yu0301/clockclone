//
//  Cell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/18.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    var jetlagLabel = UILabel()
    var capitalLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    func setCell(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func setCapitalLabel(indexpath: IndexPath,data:[String]){
        capitalLabel.adjustsFontSizeToFitWidth = true
        capitalLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        capitalLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        capitalLabel.font = UIFont.systemFont(ofSize: 25)
        capitalLabel.text = data[indexpath.row]
        addSubview(capitalLabel)
    }
    
    
    func setJetLagLabel(indexpath:IndexPath, data:[String]){
        jetlagLabel.adjustsFontSizeToFitWidth = true
        jetlagLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        jetlagLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        jetlagLabel.font = UIFont.systemFont(ofSize: 20)
        jetlagLabel.text = data[indexpath.row]
        addSubview(jetlagLabel)
    }
    
    //constraints area
    
    func setCatitalLabelConstraints(){
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 10).isActive = true
        capitalLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
        capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
    }
    
    func setJetLagConstraints(){
        jetlagLabel.translatesAutoresizingMaskIntoConstraints = false
        jetlagLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -15).isActive = true
        jetlagLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.3).isActive = true
        jetlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true

    }
    
    
}
