//
//  EditAlarmTableView.swift
//  clock
//
//  Created by 陳冠諭 on 2020/10/8.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class EditAlarmTableViewTest: UITableView {
    
    let editAlarmTableView:UITableView = {
        let editAlarmTableView = UITableView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        editAlarmTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editAlarmTableView.register(EditAlarmCell.self, forCellReuseIdentifier: "Cell")
        editAlarmTableView.rowHeight = fullScreenSize.height * 0.056
        editAlarmTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        editAlarmTableView.isScrollEnabled = false
        editAlarmTableView.tableFooterView = UIView()
        return editAlarmTableView
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame,style: style)
        addSubview(editAlarmTableView)
        editAlarmTableView.delegate = self
        editAlarmTableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditAlarmTableViewTest: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editAlarmTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditAlarmCell
        cell.textLabel?.text = "123"
        cell.backgroundColor = .white
        return cell
    }
    
}
