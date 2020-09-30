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
    let ringTone = ["111","222","333","444"]
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
       
//        cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        cell.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        cell.textLabel?.text = ringTone[indexPath.row]
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
//        cell.textLabel?.adjustsFontSizeToFitWidth = true
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
