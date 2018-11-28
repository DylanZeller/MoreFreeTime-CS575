//
//  SQLite_Example.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/26/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//
/*
import Foundation

 let eventsTable = Table("events")
 let id = Expression<Int>("id")
 let eventTitle = Expression<String>("title")
 let eventStartDate = Expression<String>("startDate")
 let eventStartTime = Expression<String>("startTime")
 let eventEndDate = Expression<String>("endDate")
 let eventEndTime = Expression<String>("endTime")
 let eventLocation = Expression<String?>("location")
 let eventDescription = Expression<String?>("description")


func createTable() {
    let createTable = self.eventsTable.create { (table) in
        table.column(self.id, primaryKey: true)
        table.column(self.eventTitle)
        table.column(self.eventStartDate)
        table.column(self.eventStartTime)
        table.column(self.eventEndDate)
        table.column(self.eventEndTime)
        table.column(self.eventLocation)
        table.column(self.eventDescription)
    }
    
    do {
        try self.database.run(createTable)
        print("Created Table")
    } catch {
        print(error)
    }
}

func deleteEvent() {
    let event = self.eventsTable.filter(self.id == 1)
    let deleteEvent = event.delete()
    do {
        try self.database.run(deleteEvent)
    } catch {
        print(error)
    }
}

func insertEvent() {
    let insertEvent = self.eventsTable.insert(self.eventTitle <- "Name", self.eventStartDate <- "EventStartDate", self.eventStartTime <- "EventStartTime",self.eventEndDate <- "EventEndDate", self.eventEndTime <- "EventEndTime", self.eventLocation <- "EventLocation", self.eventDescription <- "EventDescription")
    
    do {
        try self.database.run(insertEvent)
        print("Inserted Event")
    } catch {
        print("Error")
    }
}

func updateEvent() {
    let event = self.eventsTable.filter(self.id == 1)
    let updateEvent = event.update(self.eventLocation <- "Meet me here.")
    do {
        try self.database.run(updateEvent)
    } catch {
        print(error)
    }
}

func listEvents() {
    do {
        let events = try self.database.prepare(eventsTable)
        for event in events {
            print("eventId: \(event[self.id]), title: \(event[self.eventTitle]), location: \(event[self.eventLocation])")
        }
    } catch {
        print(error)
    }
}
 
 */
