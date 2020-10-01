//
//  SoundVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/25.
//  Copyright © 2020 KuanYu. All rights reserved.
//

//import AudioToolbox
import UIKit

protocol SetRingToneDelegate{
    func setRingTone(index:Int)
}

class RingToneVC: UIViewController {
//    將拿到的array map，被點選到的會有一個bool
    //(,) tuple?
    var ringToneArray:[(ringTong:String,isSelected:Bool)] = DataInfomation.ringTone.map{
        (ringtone:$0,isSelected: false)
    }
    var index:Int!
    var cell:RingToneTableViewCell?
    var editAlarmVC:EditAlarmVC!
    var delegate: SetRingToneDelegate?
    //for ringtonearray
    
    let ringTone = DataInfomation.ringTone
    let ringToneTableView = UITableView()
    func setRingToneTableView(){
        ringToneTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ringToneTableView.register(RingToneTableViewCell.self, forCellReuseIdentifier: "Cell")
        ringToneTableView.rowHeight = fullScreenSize.height * 0.056
        ringToneTableView.delegate = self
        ringToneTableView.dataSource = self
        ringToneTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ringToneTableView.isScrollEnabled = false
        ringToneTableView.tableFooterView = UIView()
        view.addSubview(ringToneTableView)
    }
    
    
    //MARK: - Constriants area
    func setAlarmTableViewConstraints(){
        ringToneTableView.translatesAutoresizingMaskIntoConstraints = false
        ringToneTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ringToneTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ringToneTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        let savedRingTongArray = editAlarmVC.ringTone
        print(savedRingTongArray)
        
        for _ in savedRingTongArray!{
            index = ringToneArray.firstIndex(where: { $0 == $0
            })
        //再把該index對應的布林值變成true，就會打勾
            ringToneArray[index].isSelected = true
        
        }
        
        
        title = "提示聲"
        setRingToneTableView()
        setAlarmTableViewConstraints()
        super.viewDidLoad()
        
        //讓前面的鈴聲傳進來，打勾
        
    }
}



extension RingToneVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ringToneLabel = UILabel()
        ringToneLabel.frame = CGRect(x: 20, y: 36, width: 300, height: 10)
        ringToneLabel.font = UIFont.systemFont(ofSize: 13)
        ringToneLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        ringToneLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        let headerView = UIView()
        headerView.addSubview(ringToneLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ringTone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ringToneTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RingToneTableViewCell
        cell.setRingToneTitleLabel()
        cell.setCheckMarkImageView()
        cell.ringToneTitleLabel.text = ringTone[indexPath.row]
        cell.setRingToneTitleLabelConstraint()
        cell.setCheckMarkImageViewConstriant()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "鈴聲"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = ringToneTableView.cellForRow(at: indexPath) as? RingToneTableViewCell {
            //如果為true則打勾否則什麼都沒
            ringToneArray[indexPath.row].isSelected = true
            cell.checkMarkImageView.image = ringToneArray[indexPath.row].isSelected ? UIImage(named: "checkmark") : nil
            self.cell?.checkMarkImageView.image = nil
            self.cell = cell
        }
        //被選到的那格
        index = indexPath.row
        //委託給別人做，並把值傳過去
        delegate?.setRingTone(index: index)
        ringToneTableView.deselectRow(at: indexPath, animated: true)
    }
}
