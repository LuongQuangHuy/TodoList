//
//  EdittingScreen.swift
//  TodoList
//
//  Created by Luong Quang Huy on 3/19/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class EdittingScreen: UIViewController {
    var id: String?
    var navigationDelegate: UINavigationController?
    private var theWork: Awork?
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSaveButton()
        configureDatePicker()
        configureTimePicker()
        contentTextField.delegate = self
        
        theWork = {
            for (index, data) in dataBase.enumerated(){
                if let workId = id{
                    if data.workId == workId{
                        return dataBase[index]
                        break
                    }
                }
            }
            return nil
        }()
        
        contentTextField.text = theWork?.content!
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd/MM/yyyy"
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "HH:mm"
        dayTextField.text = dayFormatter.string(from: theWork!.date!)
        timeTextField.text = timeForMatter.string(from: theWork!.date!)
    }

    func configureSaveButton(){
        saveButton.layer.borderColor = UIColor.systemGreen.cgColor
        saveButton.layer.borderWidth = 1.0
    }

    func configureDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dayTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateValueChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func dateValueChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func configureTimePicker(){
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timeTextField.inputView = timePicker
        timePicker?.addTarget(self, action: #selector(timeValueChanged(timePicker:)), for: .valueChanged)
    }
    
    @objc func timeValueChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeTextField.text = timeFormatter.string(from: timePicker.date)
        timeTextField.tintColor = .white
        
    }

    @IBAction func saveAction(_ sender: Any) {
        theWork?.content = contentTextField.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from: "\(dayTextField.text!) \(timeTextField.text!)")
        theWork?.date = date
        navigationDelegate?.popViewController(animated: true)
    }
}

extension EdittingScreen: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentTextField.backgroundColor = .white
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentTextField.backgroundColor = .systemYellow
        
    }
}
