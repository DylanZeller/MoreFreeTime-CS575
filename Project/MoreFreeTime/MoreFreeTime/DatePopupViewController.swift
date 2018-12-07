//
//  DatePopupViewController.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/25/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isStart: Bool! = false
    var currentDate : Date = Date()
    var dateOnly: Bool! = false
    
    var date: Date {
        return datePicker.date
    }
    
    var formattedDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: datePicker.date)
        }
    }
    
    var formattedDateLong: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: datePicker.date)
        }
    }
    
    var formattedTime: String {
        get {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: datePicker.date)
        }
    }
    
    var formattedDateTime: String {
        get {
            let dateTime = formattedDate + " " + formattedTime
            return dateTime
        }
    }
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.date = currentDate
        if dateOnly {
            self.datePicker.datePickerMode = UIDatePicker.Mode.date
        }
    }
    
    func setDate(currentDate : Date) {
        self.datePicker.date = currentDate
    }
    
    @IBAction func clickSave(_ sender: Any) {
        if (isStart) {
            NotificationCenter.default.post(name: Notification.Name.saveStartDateTime, object: self)
        } else {
            NotificationCenter.default.post(name: Notification.Name.saveEndDateTime, object: self)
        }
        dismiss(animated: true)
    }
}
