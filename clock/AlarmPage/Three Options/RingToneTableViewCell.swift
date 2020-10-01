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
    
    func setCheckMarkImageView(){
        checkMarkImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        checkMarkImageView.image = UIImage(named: "fateOrange")
        addSubview(checkMarkImageView)
    }
    
    func setRingToneTitleLabelConstraint(){
        ringToneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ringToneTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ringToneTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ringToneTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50).isActive = true
    }
    
    func setCheckMarkImageViewConstriant(){
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkMarkImageView.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        checkMarkImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5).isActive = true
        checkMarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.08).isActive = true
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }


}
