//
//  Event.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/26/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import Foundation
import UIKit

struct Event {
    var title : String
    var startDate : String
    var startTime : String
    var endDate : String
    var endTime : String
    var location : String
    var description : String
    
    func getStartHour() -> Int {
        let isAm = String(self.startTime.suffix(2)).isEqual("AM")
        let indexOfHour = self.startTime.firstIndex(of: ":")!
        var hour = Int(String(self.startTime[..<indexOfHour]))!
        if (isAm && hour == 12) {
            hour -= 12
        } else if (isAm == false && hour < 12) {
            hour += 12
        }
        return hour
    }
    
    func getStartMin() -> Int {
        return Int(String(self.startTime.suffix(5).prefix(2)))!
    }
    
    func getTimeInMinutes() -> Int {
        return ((60*getStartHour()) + getStartMin())
    }
    
    static func >(left: Event, right: Event) -> Bool {
        if (left.getTimeInMinutes() > right.getTimeInMinutes()) {
            return true
        } else {
            return false
        }
    }
    
    static func <(left: Event, right: Event) -> Bool {
        if (left.getTimeInMinutes() < right.getTimeInMinutes()) {
            return true
        } else {
            return false
        }
    }
}
