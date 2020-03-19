//
//  WorkDidSetCell.swift
//  TodoList
//
//  Created by Luong Quang Huy on 2/27/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class WorkDidSetCell: UITableViewCell {
    var id: String?
    var tableViewDelegate: UITableView?
    var navigationDelegate: UINavigationController?
    private var showOn: Bool!
    private var bottomViewHeightMin: NSLayoutConstraint!
    private var bottomViewHeightMax: NSLayoutConstraint!
    private let mainView = UIView()
    private let bottomView = UIView()
    let contentLabel = UILabel()
    private let dateView = UIView()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    private let editButton = UIButton()
    private let deleteButton = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bottomViewHeightMin = bottomView.heightAnchor.constraint(equalToConstant: 0.0)
        bottomViewHeightMax = bottomView.heightAnchor.constraint(equalToConstant: 50.0)
        showOn = false
        contentView.addSubview(bottomView)
        contentView.addSubview(mainView)
        configureMainView()
        configureBottomView()
        layoutBottomView()
        layoutMainView()
    }
    
    func layoutBottomView(){
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomViewHeightMin?.isActive = true
    }
    
    func layoutMainView(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    
    func configureMainView(){
        mainView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        layoutContentLabel()
        mainView.addSubview(dateView)
        configureDateView()
        mainView.isUserInteractionEnabled = true
        let showButtons = UITapGestureRecognizer(target: self, action: #selector(showButtonsAction(sender:)))
        mainView.addGestureRecognizer(showButtons)
    }
    
    @objc func showButtonsAction(sender: UIGestureRecognizer){
        if showOn{
            bottomViewHeightMax?.isActive = false
            bottomViewHeightMin?.isActive = true
            UIView.animate(withDuration: 0.25, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
            showOn = false
        }else if !showOn{
            bottomViewHeightMin?.isActive = false
            bottomViewHeightMax?.isActive = true
            UIView.animate(withDuration: 0.25, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
            showOn = true
        }
    }
    
    func layoutContentLabel(){
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
    }
    
    func configureDateView(){
        dateView.addSubview(dateLabel)
        dateView.addSubview(timeLabel)
        dateLabel.textColor = .systemRed
        timeLabel.textColor = .systemRed
        layoutDateView()
        layoutDateLabel()
        layoutTimeLabel()
    }
    
    func layoutDateView(){
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor).isActive = true
        dateView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        dateView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        dateView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
    }
    
    func layoutDateLabel(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -8).isActive = true
    }
    
    func layoutTimeLabel(){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 8).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -8).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor,constant: -8).isActive = true
    }
    
    func configureBottomView(){
        bottomView.addSubview(editButton)
        bottomView.addSubview(deleteButton)
        
        configureEditButton()
        configureDeleteButton()
    }
    
    func configureEditButton(){
        editButton.setTitle("Edit", for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .blue
        editButton.addTarget(self, action: #selector(editCell), for: .touchUpInside)
        layoutEditButton()
    }
    
    @objc func editCell(){
       if let navigation = navigationDelegate{
           let editView = EdittingScreen()
        editView.id = self.id
        editView.navigationDelegate = self.navigationDelegate
           navigation.pushViewController(editView, animated: false)
       }
    }
    
    func layoutEditButton(){
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        editButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        editButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    func configureDeleteButton(){
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.tintColor = .white
        deleteButton.backgroundColor = .red
        deleteButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        layoutDeleteButton()
    }
    
    @objc func deleteCell(){
        if let workid = id{
            for (index, data) in dataBase.enumerated(){
                if data.workId == workid{
                    dataBase.remove(at: index)
                }
            }
            if let tableView = tableViewDelegate{
                tableView.reloadData()
            }
        }
    }
    
    func layoutDeleteButton(){
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/2).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
    }
}
