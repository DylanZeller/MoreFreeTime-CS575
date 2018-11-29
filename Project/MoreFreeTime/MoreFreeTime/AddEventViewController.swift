//
//  AddEventViewController.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/25/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var eventTitleLabel: UITextField!
    @IBOutlet weak var eventLocationLabel: UITextField!
    @IBOutlet weak var eventDescriptionText: UITextView!
    
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    
    var observerStart : NSObjectProtocol?
    var observerEnd : NSObjectProtocol?
    
    var startDateTime : Date = Date()
    var endDateTime : Date = Date()
    
    var edit : Bool! = false
    var eventForEdit : Event!
    
    var defaultStartTime : String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: startDateTime)
    }
    
    var defaultEndTime : String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: endDateTime)
    }
    
    var defaultDate : String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: startDateTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.endDateTime = endDateTime.addingTimeInterval(3600)
        self.eventStartTime.text = self.defaultStartTime
        self.eventEndTime.text = self.defaultEndTime
        self.eventEndDate.text = self.defaultDate
        self.eventStartDate.text = self.defaultDate
        
        observerStart = NotificationCenter.default.addObserver(forName: .saveStartDateTime, object: nil, queue: OperationQueue.main) {
            (notification) in let dateVc = notification.object as! DatePopupViewController
            self.startDateTime = dateVc.date
            self.endDateTime = dateVc.date
            self.setStartTimes()
        }
        observerEnd = NotificationCenter.default.addObserver(forName: .saveEndDateTime, object: nil, queue: OperationQueue.main) {
            (notification) in let dateVc = notification.object as! DatePopupViewController
            self.endDateTime = dateVc.date
            self.setEndTimes()
        }
        
        if edit {
            self.pageTitle.text = "Edit Event"
            self.eventTitleLabel.text = self.eventForEdit.title
            self.eventLocationLabel.text = self.eventForEdit.location
            self.eventStartDate.text = self.eventForEdit.startDate
            self.eventStartTime.text = self.eventForEdit.startTime
            self.eventEndDate.text = self.eventForEdit.endDate
            self.eventEndTime.text = self.eventForEdit.endTime
            self.eventDescriptionText.text = self.eventForEdit.description
            //populate fields with data
        }

        // Do any additional setup after loading the view.
    }
    
    func formatThisTime(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func formatShortDate(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func setStartTimes() {
        self.eventStartTime.text = self.defaultStartTime
        self.eventStartDate.text = self.formatShortDate(date: self.startDateTime)
        self.eventEndDate.text = self.formatShortDate(date: self.startDateTime)
        let endTime : Date = self.startDateTime.addingTimeInterval(3600)
        self.eventEndTime.text = self.formatThisTime(date: endTime)
    }
    
    func setEndTimes() {
        self.eventEndTime.text = self.formatThisTime(date: self.endDateTime)
        self.eventEndDate.text = self.formatShortDate(date: self.endDateTime)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStartDatePopupView" {
            let popup = segue.destination as! DatePopupViewController
            popup.isStart = true
            popup.currentDate = startDateTime
        } else if segue.identifier == "toEndDatePopupView" {
            let popup = segue.destination as! DatePopupViewController
            popup.isStart = false
            popup.currentDate = endDateTime
        }
    }
    
    @IBAction func clickSave(_ sender: Any) {
        if edit {
            print(eventForEdit)
            //add editing event here
        } else {
            print("Adding New Event")
            let event = Event(title: self.eventTitleLabel.text ?? "(No Title)", startDate: self.eventStartDate.text!, startTime: self.eventStartTime.text!, endDate: self.eventEndDate.text!, endTime: self.eventEndTime.text!, location: self.eventLocationLabel.text ?? "No Location", description: self.eventDescriptionText.text)
            NotificationCenter.default.post(name: .saveNewEvent, object: event)
        }
        if let observerStart = observerStart {
            NotificationCenter.default.removeObserver(observerStart)
        }
        if let observerEnd = observerEnd {
            NotificationCenter.default.removeObserver(observerEnd)
        }
        dismiss(animated: true)
    }
    @IBAction func clickCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    /*@IBAction func editStartTime(_ sender: Any) {
        let sb = UIStoryboard(name: "DatePopup", bundle: nil)
        let popup = sb.instantiateInitialViewController()!
        self.present(popup,animated: true)
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
