//
//  SoundVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/25.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import AudioToolbox
import UIKit

class RingToneVC: UIViewController {
//    將拿到的array map，被點選到的會有一個bool
    //(,) tuple?
    var ringToneArray:[(ringTong:String,isSlected:Bool)] = DataInfomation.ringTone.map{
        (ringtone:$0,isSelected: false)
    }
    var delegate: SetRingToneDelegate?
//    var setAlarmVC = 
    //for ringtonearray
    var index:Int!
    let ringTone = ["雷達(預設值)","上升","山坡","公告",""]
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
        title = "提示聲"
        setRingToneTableView()
        setAlarmTableViewConstraints()
        super.viewDidLoad()
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
        cell.ringToneTitleLabel.text = ringTone[indexPath.row]
        cell.setRingToneTitleLabelConstraint()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "鈴聲"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = ringToneTableView.cellForRow(at: indexPath) {
            //點選動畫不立即生效
            
            
            
            
            ringToneTableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
}
