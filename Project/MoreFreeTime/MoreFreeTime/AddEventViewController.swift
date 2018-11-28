//
//  AddEventViewController.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/25/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventTitleLabel: UITextField!
    @IBOutlet weak var eventLocationLabel: UITextField!
    @IBOutlet weak var eventDescriptionText: UITextView!
    
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    
    var observerStart : NSObjectProtocol?
    var observerEnd : NSObjectProtocol?
    
    var defaultStartTime : String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let date = Date()
        return formatter.string(from: date)
    }
    
    var defaultEndTime : String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let date = Date().addingTimeInterval(3600)
        return formatter.string(from: date)
    }
    
    var defaultDate : String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventStartTime.text = self.defaultStartTime
        self.eventEndTime.text = self.defaultEndTime
        self.eventEndDate.text = self.defaultDate
        self.eventStartDate.text = self.defaultDate
        
        observerStart = NotificationCenter.default.addObserver(forName: .saveStartDateTime, object: nil, queue: OperationQueue.main) {
            (notification) in let dateVc = notification.object as! DatePopupViewController
            self.eventStartTime.text = dateVc.formattedTime
            self.eventStartDate.text = dateVc.formattedDate
            self.eventEndDate.text = dateVc.formattedDate
        }
        observerEnd = NotificationCenter.default.addObserver(forName: .saveEndDateTime, object: nil, queue: OperationQueue.main) {
            (notification) in let dateVc = notification.object as! DatePopupViewController
            self.eventEndTime.text = dateVc.formattedTime
            self.eventEndDate.text = dateVc.formattedDate
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStartDatePopupView" {
            let popup = segue.destination as! DatePopupViewController
            popup.isStart = true
        }
    }
    
    @IBAction func clickSave(_ sender: Any) {
        let event = Event(title: self.eventTitleLabel.text ?? "(No Title)", startDate: self.eventStartDate.text!, startTime: self.eventStartTime.text!, endDate: self.eventEndDate.text!, endTime: self.eventEndTime.text!, location: self.eventLocationLabel.text ?? "No Location", description: self.eventDescriptionText.text)
        NotificationCenter.default.post(name: .saveNewEvent, object: event)
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
