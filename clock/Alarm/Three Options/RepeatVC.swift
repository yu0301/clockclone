//
//  RepeatVC.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/22.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class RepeatVC: UIViewController {
    
    var date = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
    var dateTableView = UITableView()
    
    func setDateTableView(){
        dateTableView.frame = CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height)
        dateTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        dateTableView.rowHeight = 80
        dateTableView.delegate = self
        dateTableView.dataSource = self
        view.addSubview(dateTableView)
    }
    
    func setAlarmTableViewConstraints(){
        dateTableView.translatesAutoresizingMaskIntoConstraints = false
        dateTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dateTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dateTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        dateTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setDateTableView()
        setAlarmTableViewConstraints()
        super.viewDidLoad()
    }
}

extension RepeatVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dateTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        cell.textLabel?.text = date[indexPath.row]
        return cell
    }
    
}
