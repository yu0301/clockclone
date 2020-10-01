//
//  RingToneTableViewCell.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/30.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class RingToneTableViewCell: UITableViewCell {

    
    let ringToneTitleLabel = UILabel()
    let checkMarkImageView = UIImageView()
    
    func setRingToneTitleLabel(){
        ringToneTitleLabel.adjustsFontSizeToFitWidth = true
        ringToneTitleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ringToneTitleLabel.font = UIFont.systemFont(ofSize: 17)
        ringToneTitleLabel.adjustsFontSizeToFitWidth = true
        addSubview(ringToneTitleLabel)
    }
    
    func setRingToneTitleLabelConstraint(){
        ringToneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ringToneTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ringToneTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ringToneTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50).isActive = true
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }


}
