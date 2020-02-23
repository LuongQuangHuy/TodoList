//
//  ViewController.swift
//  TodoList
//
//  Created by Luong Quang Huy on 2/23/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //ViewController properties
    let menuTableView = UITableView()
    var dataMenuItem: [String] = []
    //outLet properties
    @IBOutlet weak var idiaIcon: UIImageView!
    @IBOutlet weak var dhcIcon: UIImageView!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var databaseIcon: UIImageView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var addNewItemButton: UIButton!
    @IBOutlet weak var showAllWorkButton: UIButton!
    @IBOutlet weak var showAllWorkToDayButton: UIButton!
    @IBOutlet weak var showOutTimeWorkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataMenuItem = fakeDataMenuItem()
        configureMenuButtonAction()
        configureMainItemButton()
    }
    
    func configureMenuButtonAction(){
        configureDarkView()
        configureMenuView()
    }
    
    func configureDarkView(){
        darkView.isUserInteractionEnabled = true
               let clickDarkView = UITapGestureRecognizer(target: self, action: #selector(backToMainView))
               darkView.addGestureRecognizer(clickDarkView)
    }
    
    func configureMenuView(){
        menuView.addSubview(menuTableView)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: "MainViewMenuItem", bundle: nil), forCellReuseIdentifier: "MenuCell")
        layoutMenuTableView()
    }
    
    func layoutMenuTableView(){
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.topAnchor.constraint(equalTo: menuView.topAnchor).isActive = true
        menuTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        
    }
    
    func configureMainItemButton(){
        addNewItemButton.layer.cornerRadius = 10.0
        showOutTimeWorkButton.layer.cornerRadius = 10.0
        showAllWorkToDayButton.layer.cornerRadius = 10.0
        showAllWorkButton.layer.cornerRadius = 10.0
        layoutIcon()
    }
    
    func layoutIcon(){
        let someSpacing = idiaIcon.bounds.size.width/2
        //layout idia icon
        idiaIcon.translatesAutoresizingMaskIntoConstraints = false
        idiaIcon.centerYAnchor.constraint(equalTo: addNewItemButton.centerYAnchor).isActive = true
        idiaIcon.trailingAnchor.constraint(equalTo: addNewItemButton.leadingAnchor, constant: someSpacing).isActive = true
        //layout dhcIcon
        dhcIcon.translatesAutoresizingMaskIntoConstraints = false
        dhcIcon.centerYAnchor.constraint(equalTo: showOutTimeWorkButton.centerYAnchor).isActive = true
        dhcIcon.trailingAnchor.constraint(equalTo: showOutTimeWorkButton.leadingAnchor, constant: someSpacing).isActive = true
        //layout calendar icon
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        calendarIcon.centerYAnchor.constraint(equalTo: showAllWorkToDayButton.centerYAnchor).isActive = true
        calendarIcon.trailingAnchor.constraint(equalTo: showAllWorkToDayButton.leadingAnchor, constant: someSpacing).isActive = true
        //layout database icon
        databaseIcon.translatesAutoresizingMaskIntoConstraints = false
        databaseIcon.centerYAnchor.constraint(equalTo: showAllWorkButton.centerYAnchor).isActive = true
        databaseIcon.trailingAnchor.constraint(equalTo: showAllWorkButton.leadingAnchor, constant: someSpacing).isActive = true
        
        
    }
    
    @objc func backToMainView(){
        view.sendSubviewToBack(darkView)
        view.sendSubviewToBack(menuView)
    }
    @IBAction func clickMenuButton(_ sender: Any) {
        view.bringSubviewToFront(darkView)
        view.bringSubviewToFront(menuView)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Menu"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MainViewMenuItem
        cell.label.text = dataMenuItem[indexPath.row]
        return cell
    }
}

extension ViewController{
    func fakeDataMenuItem() -> [String]{
           return ["Cài đặt" , "Quản lý dữ liệu" , "Thoát ứng dụng"]
       }
}
