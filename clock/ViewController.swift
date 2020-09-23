//
//  ViewController.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/13.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = ["Taipei","Washington","Tokyo","Seoul","London"]
    var jetLag = ["Today, +0HRS","Today, +0HRS","Today, +0HRS","Today, +0HRS","Today, +0HRS"]
    
    var myNavigationBar = UINavigationBar()
    var myNavigationbarItem = UINavigationItem(title: "World Clock")
    var myTableView = UITableView()
    var myTabbarController = UITabBarController()

    
    
    
    //Navigationbar
    func setMyNavigationBar(){
        myNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myNavigationBar.setItems([myNavigationbarItem], animated: false)
        view.addSubview(myNavigationBar)
    }
    
    //leftbtn
    func setLeftBtn(){
        if myTableView.isEditing == false {
            myNavigationbarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,target: self, action: #selector(doneTapped))
        }else{
            myNavigationbarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(doneTapped))
        }
    }
    
    //rightbtn
    func setRightBtn(){
        myNavigationbarItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    //leftbtn action
    @objc func doneTapped(){
        if myTableView.isEditing == true {
            myTableView.setEditing(false, animated: true)
            setLeftBtn()
        }else{
            myTableView.setEditing(true, animated: true)
            setLeftBtn()
        }
    }
    
    //rightbtn action
    @objc func addTapped(){
        print(456)
    }
    
    //tableview
    func setMyTableView(){
        myTableView.frame = CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height)
        myTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myTableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        myTableView.rowHeight = 80
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
    }
    
    
    
    
    
    
    //tabbar
    func setMyTabBarController(){
        myTabbarController.tabBar.backgroundColor = .white
        let vc1 = WorldClock()
        let vc2 = Alarm()
        let vc3 = BedTime()
        let vc4 = StopWatch()
        let vc5 = Timer()
        vc1.tabBarItem.image = UIImage(systemName: "circle")
        vc1.tabBarItem.title = "World Clock"
        vc2.tabBarItem.image = UIImage(systemName: "alarm.fill")
        vc2.tabBarItem.title = "Alarm"
        vc3.tabBarItem.image = UIImage(systemName: "bed.double.fill")
        vc3.tabBarItem.title = "Bedtime"
        vc4.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        vc4.tabBarItem.title = "Stopwatch"
        vc5.tabBarItem.image = UIImage(systemName: "timer")
        vc5.tabBarItem.title = "Timer"
        
        myTabbarController.setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: false)
        self.view.addSubview(myTabbarController.view)
        
    }
    
    
    
    //constraint區
    func setTableViewContraints(){
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: myNavigationBar.bottomAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setMyNavigationBarConstraints(){
        myNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        myNavigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myNavigationBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        myNavigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setUI(){
        setMyTableView()
        setMyNavigationBar()
        setRightBtn()
        setLeftBtn()
        setTableViewContraints()
        setMyNavigationBarConstraints()
        setMyTabBarController()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setUI()
        super.viewDidLoad()
        
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.setCell()
        cell.setCapitalLabel(indexpath: indexPath, data: data)
        cell.setJetLagLabel(indexpath: indexPath, data: jetLag)
        cell.setCatitalLabelConstraints()
        cell.setJetLagConstraints()
        return cell
    }
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myTableView.beginUpdates()
            myTableView.deleteRows(at: [indexPath], with: .fade)
            data.remove(at: indexPath.row)
            myTableView.endUpdates()
        }
    }
}




   
