//
//  AddNewScreen.swift
//  TodoList
//
//  Created by Luong Quang Huy on 3/18/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit
class AddNewScreen: UIViewController {
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?

    @IBOutlet weak var inputContent: UITextField!
    @IBOutlet weak var inputDay: UITextField!
    @IBOutlet weak var inputTime: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureContainerView()
        configureAddButton()
        configureDatePicker()
        configureTimePicker()
        inputContent.delegate = self
    }
    
    func configureNavigationBar(){
        navigationItem.title = "Thêm nội dung công việc"
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeThisScreen))
    }
    
    @objc func closeThisScreen(){
        dismiss(animated: false, completion: nil)
    }
    
    func configureContainerView(){
        containerView.isUserInteractionEnabled = true
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gesuture:)))
        containerView.addGestureRecognizer(viewTapGesture)
    }
    
    @objc func viewTapped(gesuture: UIGestureRecognizer){
        containerView.endEditing(true)
    }

    func configureAddButton(){
        addButton.layer.cornerRadius = 10.0
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.borderWidth = 2.0
    }
    
    func configureDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        inputDay.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateValueChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func dateValueChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        inputDay.text = dateFormatter.string(from: datePicker.date)
        inputDay.backgroundColor = .systemYellow
        containerView.endEditing(true)
    }
    
    func configureTimePicker(){
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        inputTime.inputView = timePicker
        timePicker?.addTarget(self, action: #selector(timeValueChanged(timePicker:)), for: .valueChanged)

    }
    
    @objc func timeValueChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        inputTime.text = timeFormatter.string(from: timePicker.date)
        inputTime.backgroundColor = .systemYellow
        containerView.endEditing(true)
    }

    @IBAction func addNewAction(_ sender: Any) {
        let calendar = Calendar.current
        let content = inputContent.text
        let h = calendar.component(.hour, from: timePicker!.date)
        let mn = calendar.component(.minute, from: timePicker!.date)
        let day = calendar.component(.day, from: datePicker!.date)
        let month = calendar.component(.month, from: datePicker!.date)
        let year = calendar.component(.year, from: datePicker!.date)
       let dateComponents = DateComponents(calendar: calendar, timeZone: nil, era: nil, year: year, month: month, day: day, hour: h, minute: mn, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date = calendar.date(from: dateComponents)
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let id = dateFormatter.string(from: now)
        let newWork = Awork(content: content, date: date, workId: id)
        dataBase.append(newWork)
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewScreen: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputContent.backgroundColor = .systemYellow
    }
}
