//
//  DatabaseManager.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 12/6/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import Foundation
import SQLite
class DatabaseManager {
    var database : Connection!
    final var databaseName : String = "MoreFreeTime"
    final var databaseExt : String = "sqlite3"
    
    let eventsTable = Table("events")
    let id = Expression<Int>("id")
    let eventTitle = Expression<String>("title")
    let eventStartDate = Expression<String>("startDate")
    let eventStartTime = Expression<String>("startTime")
    let eventEndDate = Expression<String>("endDate")
    let eventEndTime = Expression<String>("endTime")
    let eventLocation = Expression<String>("location")
    let eventDescription = Expression<String?>("description")

    init() {
        do {
            let docDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = docDirectory.appendingPathComponent(databaseName).appendingPathExtension(databaseExt)
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        createTable()
    }
    
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
        } catch {
            print(error)
        }
    }
    
    func deleteTable() {
        let deleteTable = self.eventsTable.delete()
        do {
            try self.database.run(deleteTable)
        } catch {
            print(error)
        }
    }
    
    func deleteEvent(id : Int) {
        let event = self.eventsTable.filter(self.id == id)
        let deleteEvent = event.delete()
        do {
            try self.database.run(deleteEvent)
        } catch {
            print(error)
        }    }
    
    func insertEvent(e : Event) {
        let insertEvent = self.eventsTable.insert(self.eventTitle <- e.title, self.eventStartDate <- e.startDate, self.eventStartTime <- e.startTime, self.eventEndDate <- e.endDate, self.eventEndTime <- e.endTime, self.eventLocation <- e.location, self.eventDescription <- e.description)
        do {
            try self.database.run(insertEvent)
        } catch {
            print(error)
        }
    }
    
    func updateEvent(e : Event) {
        let event = self.eventsTable.filter(self.id == e.id)
        let updateEvent = event.update(self.eventTitle <- e.title, self.eventStartDate <- e.startDate, self.eventStartTime <- e.startTime, self.eventEndDate <- e.endDate, self.eventEndTime <- e.endTime, self.eventLocation <- e.location, self.eventDescription <- e.description)
        do {
            try self.database.run(updateEvent)
        } catch {
            print(error)
        }
    }
    
    func fetchEvents(currentShortDate : String) -> [Event] {
        var todaysEvents : [Event] = []
        do {
            let dbEvents = try self.database.prepare(eventsTable)
            for dbEvent in dbEvents {
                if dbEvent[self.eventStartDate].isEqual(currentShortDate) {
                    let event = Event(title: dbEvent[self.eventTitle], startDate: dbEvent[self.eventStartDate], startTime: dbEvent[self.eventStartTime], endDate: dbEvent[self.eventEndDate], endTime: dbEvent[self.eventEndTime], location: dbEvent[self.eventLocation], description: dbEvent[self.eventDescription]!, id: dbEvent[self.id])
                    todaysEvents.append(event)
                }
            }
        } catch {
            print(error)
        }
        return todaysEvents
    }
    
    func listAllEvents() {
        do {
            let events = try self.database.prepare(eventsTable)
            for event in events {
                print("eventId: \(event[self.id]), title: \(event[self.eventTitle]), startDate: \(event[self.eventStartDate]), startTime: \(event[self.eventStartTime]), endDate: \(event[self.eventEndDate]), endTime: \(event[self.eventEndTime]),location: \(event[self.eventLocation]), description: \(event[self.eventDescription]!),")
            }
        } catch {
            print(error)
        }
    }
}
