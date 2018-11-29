//
//  EventSingleDayCell.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/27/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit

class EventSingleDayCell: UITableViewCell {

    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    @IBOutlet weak var editThisEvent: UIButton!
    
    var housedEvent : Event!
    
    func setEvent(event : Event) {
        self.housedEvent = event
        self.eventName.text = event.title
        self.eventLocation.text = event.location
        self.eventStartTime.text = event.startTime
        self.eventEndTime.text = event.endTime
    }
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
