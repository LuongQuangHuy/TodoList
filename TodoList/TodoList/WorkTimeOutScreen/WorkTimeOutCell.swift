//
//  WorkTimeOutCell.swift
//  TodoList
//
//  Created by Luong Quang Huy on 3/3/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class WorkTimeOutCell: UITableViewCell {

    
    @IBOutlet weak var contentlabel: UILabel!
    @IBOutlet weak var confirmButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       configureConfirmButton()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureConfirmButton(){
        confirmButton.layer.borderColor = UIColor.black.cgColor
        confirmButton.layer.borderWidth = 1.0
        confirmButton.layer.cornerRadius = confirmButton.bounds.width/2
        
        setUpConfirmAction()
        
    }
    
    func setUpConfirmAction(){
        confirmButton.isUserInteractionEnabled = true
        let tapConfirm = UITapGestureRecognizer(target: self, action: #selector(didTapConfirm))
        confirmButton.addGestureRecognizer(tapConfirm)
    }
    
    @objc func didTapConfirm(){
        confirmButton.layer.borderColor = UIColor.white.cgColor
        confirmButton.image = UIImage(named: "checkIcon")
    }
}
