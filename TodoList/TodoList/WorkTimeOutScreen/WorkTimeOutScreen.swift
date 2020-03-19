//
//  WorkTimeOutScreen.swift
//  TodoList
//
//  Created by Luong Quang Huy on 3/3/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class WorkTimeOutScreen: UIViewController {
    private var outTimeWork: [Awork] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         filterResult()
        configureTableView()
        configureNavigationBar()
    }


    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WorkTimeOutCell", bundle: nil), forCellReuseIdentifier: "timeOutCell")
        
    }
    
    func configureNavigationBar(){
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen))
        navigationItem.title = "Công việc đã đến hạn"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func closeScreen(){
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    func filterResult(){
        let result = dataBase.filter({$0.isOutTime()})
        outTimeWork = result
    }

}

extension WorkTimeOutScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outTimeWork.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeOutCell") as! WorkTimeOutCell
        cell.contentlabel.text = outTimeWork[indexPath.row].content!
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let id = outTimeWork[indexPath.row].workId
            outTimeWork.remove(at: indexPath.row)
            for (index,data) in dataBase.enumerated(){
                if data.workId == id{
                    dataBase.remove(at: index)
                }
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
