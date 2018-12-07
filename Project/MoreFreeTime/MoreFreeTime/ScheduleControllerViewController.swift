//
//  ScheduleControllerViewController.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/25/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import UIKit
import SQLite
class ScheduleControllerViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    var database : DatabaseManager!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateObserver : NSObjectProtocol?
    var newEventObserver : NSObjectProtocol?
    var editedEventObserver : NSObjectProtocol?
    var deleteEventObserver : NSObjectProtocol?
    
    var currentDate : Date = Date()
    var newEvent : Event?
    var events : [Event] = []
    
    var formattedDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: self.currentDate)
        }
    }
    
    var formattedShortDate : String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self.currentDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This will open and set the global database
        database = DatabaseManager()
        
        addObservers()
        
        dateLabel.text = formattedDate
        
        tableView.delegate = self
        tableView.dataSource = self
        getTodaysEvents()
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ScheduleControllerViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    func addObservers() {
        dateObserver = NotificationCenter.default.addObserver(forName: .saveStartDateTime, object: nil, queue: OperationQueue.main) {
            (notification) in let dateVc = notification.object as! DatePopupViewController
            self.currentDate = dateVc.date
            self.dateLabel.text = dateVc.formattedDateLong
            self.getTodaysEvents()
        }
        newEventObserver = NotificationCenter.default.addObserver(forName: .saveNewEvent, object: nil, queue: OperationQueue.main) {
            (notification) in let newEvent = notification.object as! Event
            self.insertEvent(e: newEvent)
            self.getTodaysEvents()
        }
        editedEventObserver = NotificationCenter.default.addObserver(forName: .saveEditedEvent, object: nil, queue: OperationQueue.main) {
            (notification) in let editedEvent = notification.object as! Event
            self.updateEvent(e: editedEvent)
            self.getTodaysEvents()
        }
        deleteEventObserver = NotificationCenter.default.addObserver(forName: .deleteEvent, object: nil, queue: OperationQueue.main) {
            (notification) in let deleteEventId = notification.object as! Int
            self.deleteEvent(id : deleteEventId)
        }
    }
    
    func getTodaysEvents() {
        self.events = database.fetchEvents(currentShortDate: formattedShortDate)
        self.sortEvents()
        self.tableView.reloadData()
    }
    
    func sortEvents() {
        events = events.sorted(by: { $0 < $1 })
    }
    
    func deleteEvent(id : Int) {
        database.deleteEvent(id: id)
        self.getTodaysEvents()
    }
    
    func insertEvent(e : Event) {
        database.insertEvent(e: e)
    }
    
    func updateEvent(e : Event) {
        database.updateEvent(e: e)
    }
    
    func listEvents() {
        let allEventsString = database.listAllEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentDatePopupView" {
            let popup = segue.destination as! DatePopupViewController
            popup.isStart = true
            popup.currentDate = self.currentDate
            popup.dateOnly = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let dateObserver = dateObserver {
            NotificationCenter.default.removeObserver(dateObserver)
        }
        if let newEventObserver = newEventObserver {
            NotificationCenter.default.removeObserver(newEventObserver)
        }
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let vc = UIStoryboard(name: "EventsController", bundle: nil).instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
                vc.edit = true
                vc.eventForEdit = events[indexPath.row]
                let navigationController = UINavigationController(rootViewController: vc)
                self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
}

extension ScheduleControllerViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventSingleDayCell") as! EventSingleDayCell
        cell.setEvent(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "EventsController", bundle: nil).instantiateViewController(withIdentifier: "ViewEventViewController") as! ViewEventViewController
        vc.viewEvent = events[indexPath.row]
        let navigationController = UINavigationController(rootViewController: vc)
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
}
