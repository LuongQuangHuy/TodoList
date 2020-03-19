//
//  AllWorkToDayScreen.swift
//  TodoList
//
//  Created by Luong Quang Huy on 2/27/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class AllWorkToDayScreen: UIViewController {
    private var todayWork: [Awork] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterResult()
        configureNavigationBar()
        configureTableView()
    }

    func configureNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        let calendar = NSCalendar.current
        let today = Date()
        let day = calendar.component(.day, from: today)
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        navigationItem.title = "\(day)/\(month)/\(year)"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func closeScreen(){
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkDidSetCell.self, forCellReuseIdentifier: "WorkDidSetCell")
    }
    
    func filterResult(){
        
        let result = dataBase.filter({$0.isToDay()})
        todayWork = result
    }

}

extension AllWorkToDayScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWork.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkDidSetCell") as! WorkDidSetCell
        cell.contentLabel.text = todayWork[indexPath.row].content!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        cell.dateLabel.text = dateFormatter.string(from: todayWork[indexPath.row].date!)
        cell.timeLabel.text = timeFormatter.string(from: todayWork[indexPath.row].date!)
        cell.id = todayWork[indexPath.row].workId
        cell.tableViewDelegate = tableView
        cell.navigationDelegate = self.navigationController
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.01, animations: {
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
}
