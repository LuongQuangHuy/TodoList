//
//  AllWorkDidSetScreen.swift
//  TodoList
//
//  Created by Luong Quang Huy on 2/27/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class AllWorkDidSetScreen: UIViewController {
    var searchController: UISearchController!
    
    private var currentDataSource: [Awork] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDataSource = dataBase
        configureTableView()
        configureNavigationBar()
        
        createObserver()
        
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkDidSetCell.self, forCellReuseIdentifier: "WorkDidSetCell")
    }

    func configureNavigationBar(){
        navigationItem.title = "Tất cả công việc đã tạo"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        searchController.hidesNavigationBarDuringPresentation = false
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func closeScreen(){
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    func filterResult(searchTerm: String){
        if searchTerm.count > 0{
            currentDataSource = dataBase
            let searchResult = currentDataSource.filter({$0.content!.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())})
            currentDataSource = searchResult
            tableView.reloadData()
        }
    }
    
    func resetCurrentDataSource(){
        currentDataSource = dataBase
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataTableView(notification:)), name: Notification.Name(rawValue: "deleted Cell"), object: nil)
    }
    
    @objc func reloadDataTableView(notification: NSNotification){
        if let data = notification.userInfo as? [IndexPath : Int]{
            for (indexPath , row) in data{
                currentDataSource.remove(at: row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension AllWorkDidSetScreen: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkDidSetCell") as! WorkDidSetCell
        cell.contentLabel.text = currentDataSource[indexPath.row].content!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        cell.dateLabel.text = dateFormatter.string(from: currentDataSource[indexPath.row].date!)
        cell.timeLabel.text = timeFormatter.string(from: currentDataSource[indexPath.row].date!)
        cell.id = currentDataSource[indexPath.row].workId
        cell.navigationDelegate = self.navigationController
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.01, animations: {
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
}

extension AllWorkDidSetScreen: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
        filterResult(searchTerm: searchText)
        }
    }
    
    
}

extension AllWorkDidSetScreen: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        resetCurrentDataSource()
    }
}
