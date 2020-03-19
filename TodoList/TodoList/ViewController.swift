//
//  ViewController.swift
//  TodoList
//
//  Created by Luong Quang Huy on 2/23/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit
var dataBase: [Awork] = []
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
    }
    
    
    @objc func backToMainView(){
        view.sendSubviewToBack(darkView)
        view.sendSubviewToBack(menuView)
    }
    @IBAction func clickMenuButton(_ sender: Any) {
        view.bringSubviewToFront(darkView)
        view.bringSubviewToFront(menuView)
    }
    
    @IBAction func addNewWorkAction(_ sender: Any) {
        let addNewScreen = AddNewScreen()
        let navigation = UINavigationController(rootViewController: addNewScreen)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: false)
    }
    
    @IBAction func showTimeOutWorkAction(_ sender: Any) {
        let workTimeOutScreen = WorkTimeOutScreen()
        let navigation = UINavigationController(rootViewController: workTimeOutScreen)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: false)
    }
    
    @IBAction func showAllWorkTodayAction(_ sender: Any) {
        let allWorkTodayScreen = AllWorkToDayScreen()
        let navigation = UINavigationController(rootViewController: allWorkTodayScreen)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: false)
    }
    @IBAction func showAllWorkAction(_ sender: Any) {
        let allWorkDidSetScreen = AllWorkDidSetScreen()
        let navigation = UINavigationController(rootViewController: allWorkDidSetScreen)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: false)
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
           return ["Quản lý dữ liệu" , "Thoát ứng dụng"]
       }
}
