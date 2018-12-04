//
//  ViewEventViewController.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 12/4/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit

class ViewEventViewController: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet weak var deleteEventButton: UIButton!
    
    var viewEvent : Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    func setLabels() {
        eventTitle.text = viewEvent.title
        eventLocation.text = viewEvent.location
        eventStartDate.text = viewEvent.startDate
        eventStartTime.text = viewEvent.startTime
        eventEndDate.text = viewEvent.endDate
        eventEndTime.text = viewEvent.endTime
        eventDescription.text = viewEvent.description
    }
    
    @IBAction func deleteEventButton_Clicked(_ sender: Any) {
        NotificationCenter.default.post(name: .deleteEvent, object: self.viewEvent.id)
        dismiss(animated: true)
    }
    
    @IBAction func clickReturnButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
