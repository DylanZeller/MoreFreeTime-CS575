//
//  NotificationNameExtention.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/25/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let saveStartDateTime = Notification.Name(rawValue: "saveStartDateTime")
    static let saveEndDateTime = Notification.Name(rawValue: "saveEndDateTime")
    static let saveNewEvent = Notification.Name(rawValue: "saveNewEvent")
    static let saveEditedEvent = Notification.Name(rawValue: "saveEditedEvent")
    static let deleteEvent = Notification.Name(rawValue: "deleteEvent")
}
