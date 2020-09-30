//
//  ViewController.swift
//  clock
//
//  Created by 陳冠諭 on 2020/9/13.
//  Copyright © 2020 KuanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = [""]
    var jetLag = [""]
    let myNavigationController = UINavigationController()
    var myNavigationBar = UINavigationBar()
    var myNavigationbarItem = UINavigationItem(title: "世界鬧鐘")
    var myTableView = UITableView()
    var myTabbarController = UITabBarController()

    
    //Set navigationBar title
    let attrs = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
    ]
    
    //Navigationbar
    func setMyNavigationBar(){
        myNavigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myNavigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myNavigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = attrs
        myNavigationBar.setItems([myNavigationbarItem], animated: false)
        view.addSubview(myNavigationBar)
    }
    
    //leftbtn
    func setLeftBtn(){
        if myTableView.isEditing == false {
            myNavigationbarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,target: self, action: #selector(editTapped))
        }else{
            myNavigationbarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(editTapped))
        }
    }
    
    //rightbtn
    func setRightBtn(){
        myNavigationbarItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    //leftbtn action
    @objc func editTapped(){
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
    
    
    
    
    //MARK: -Set tabbar
    func setMyTabBarController(){
        myTabbarController.tabBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myTabbarController.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myTabbarController.tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let vc1 = UIViewController()
        let vc2 = AlarmViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        vc1.tabBarItem.image = UIImage(systemName: "globe")
        vc1.tabBarItem.title = "世界時鐘"
        vc2.tabBarItem.image = UIImage(systemName: "alarm.fill")
        vc2.tabBarItem.title = "鬧鐘"
        vc3.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        vc3.tabBarItem.title = "碼表"
        vc4.tabBarItem.image = UIImage(systemName: "timer")
        vc4.tabBarItem.title = "計時器"
        
        myTabbarController.setViewControllers([vc1,vc2,vc3,vc4], animated: false)
        self.view.addSubview(myTabbarController.view)
        
    }
    
    
    
    //MARK:- Constraints
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
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        setUI()
        super.viewDidLoad()
        
    }
}

//MARK:- numbers of row nad section
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




   
