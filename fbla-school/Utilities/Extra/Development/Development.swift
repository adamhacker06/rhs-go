//
//  Development.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import Foundation

class Development {
    static var chickenSandwich = Food(type: .entree, name: "Chicken Sandwich", portion: "1 serving", calories: "390 kcal", sugars: "3.0 grams", protein: "20.0 grams", carbs: "42.0 grams", transFat: "16.5 grams")
    
    static var schedule = ClassSchedule(prefirst: SchoolClass(administrator: "Russell Brown", namePrefix: .mr, title: "Precalcus", email: "rbrown@vusd.org"), first: SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"), second: SchoolClass(administrator: "Russell Brown", namePrefix: .mr, title: "Construction Management", email: "rbown@vusd.org"), third: SchoolClass(administrator: "Javier Quezada", namePrefix: .mr, title: "Math 3 Honors", email: "jquezada@vusd.org"), fourth: SchoolClass(administrator: "Kelli Feehan", namePrefix: .mrs, title: "English 2 Honors", email: "kfeehan@vusd.org"), fifth: SchoolClass(administrator: "Jacob Avila", namePrefix: .mr, title: "Foundations of Business", email: "javila@vusd.org"), sixth: SchoolClass(administrator: "Jonathan Woodbury", namePrefix: .mr, title: "Biology", email: "jwoodbury@vusd.org"))
    
    static var gigantea = GiganteaModel(articles: [Article(title: "Ranger men's choir perform with the sequoia something at Fox theater", author: "Yoselin Reynoso", publishedDate: Date(), category: "Arts and Entertainment", htmlContent: "", paragraphContent: ["First", "Second", "Third"]), Article(title: "softball sophomore break school record for most homeruns hit in a single game", author: "Olivia Gonzalez", publishedDate: Date(), category: "Sports", htmlContent: "", paragraphContent: ["First", "Second", "Third"]), Article(title: "The privilege of playing at Rawhide", author: "Ellie Gilbert", publishedDate: Date(), category: "Sports", htmlContent: "", paragraphContent: ["First", "Second"])])
    
    static var calendarDataManager = CalendarDataManager(lastUpdated: Date.now, calendar: Development.calendar, isUpdating: false)
    
    static var calendar = GoogleAPICalendar(kind: "", etag: "", summary: "", updated: "", timeZone: "", accessRole: "", defaultReminders: [], nextSyncToken: nil, nextPageToken: nil, items: [
        CalendarItem(
            kind: "calendar#event",
            etag: "\"3298580649226000\"",
            id: "2kp8bt7q0k3q14vhr7fcelsj8r",
            status: "confirmed",
            htmlLink: "https://www.google.com/calendar/event?eid=MmtwOGJ0N3EwazNxMTR2aHI3ZmNlbHNqOHIgY183NGhoOXEzbGpnOWthMDYwdW5tZTNmdWU0OEBn",
            created: "2022-04-07T00:12:04.000Z",
            updated: "2022-04-07T00:12:04.613Z",
            summary: "Internship Info Meeting",
            creator: CalendarCreator(email: "adam.ha4294@vusd.us", displayName: "Adam Hacker"),
            organizer: CalendarOrganizer(email: "c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com", displayName: "Redwood School Events", organizerSelf: true),
            start: CalendarDate(date: nil, dateTime: "2022-04-18T15:20:00-07:00"),
            end: CalendarDate(date: nil, dateTime: "2022-04-18T16:00:00-07:00"),
            transparency: nil,
            iCalUID: "2kp8bt7q0k3q14vhr7fcelsj8r@google.com",
            sequence: 0,
            eventType: "default",
            location: "Redwood High School, 1001 W Main St, Visalia, CA 93291, USA"),
        
        CalendarItem(
            kind: "calendar#event",
            etag: "\"3298580472332000\"",
            id: "77tsnjffqpgh9pj34bc10b16d9",
            status: "confirmed",
            htmlLink: "https://www.google.com/calendar/event?eid=Nzd0c25qZmZxcGdoOXBqMzRiYzEwYjE2ZDkgY183NGhoOXEzbGpnOWthMDYwdW5tZTNmdWU0OEBn",
            created: "2022-04-05T21:35:24.000Z",
            updated: "2022-04-07T00:10:36.166Z",
            summary:  "Tennis Match (V)",
            creator: CalendarCreator(email: "adam.ha4294@vusd.us", displayName: "Adam Hacker"),
            organizer: CalendarOrganizer(email: "c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com", displayName: "Redwood School Events", organizerSelf: true),
            start: CalendarDate(date: nil, dateTime: "2022-04-19T15:30:00-07:00"),
            end: CalendarDate(date: nil, dateTime: "2022-04-19T19:00:00-07:00"),
            transparency: nil,
            iCalUID: "77tsnjffqpgh9pj34bc10b16d9@google.com",
            sequence: 0,
            eventType: "default",
            location: "Clovis High School, 1055 Fowler Ave, Clovis, CA 93611, USA"),
        
        CalendarItem(
            kind: "calendar#event",
            etag: "\"3298764205430000\"",
            id: "7h4bs76i26k4oshb2kqi9kk73q",
            status: "confirmed",
            htmlLink: "https://www.google.com/calendar/event?eid=N2g0YnM3NmkyNms0b3NoYjJrcWk5a2s3M3EgY183NGhoOXEzbGpnOWthMDYwdW5tZTNmdWU0OEBn",
            created: "2022-04-08T01:41:42.000Z",
            updated: "2022-04-08T01:41:42.715Z",
            summary: "Track Meet",
            creator: CalendarCreator(email: "adam.ha4294@vusd.us", displayName: "Adam Hacker"),
            organizer: CalendarOrganizer(email: "c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com", displayName: "Redwood School Events", organizerSelf: true),
            start: CalendarDate(date: nil, dateTime: "2022-04-22T10:00:00-07:00"),
            end: CalendarDate(date: nil, dateTime: "2022-04-22T16:00:00-07:00"),
            transparency: nil,
            iCalUID: "7h4bs76i26k4oshb2kqi9kk73q@google.com",
            sequence: 0,
            eventType: "default",
            location: "Golden West High School Band Program, 1717 N McAuliff St, Visalia, CA 93292, USA"),
        
        CalendarItem(
            kind: "calendar#event",
            etag: "\"3298764205430000\"",
            id: "7h4bs76i26k4oshb2kqi9kk73q",
            status: "confirmed",
            htmlLink: "https://www.google.com/calendar/event?eid=N2g0YnM3NmkyNms0b3NoYjJrcWk5a2s3M3EgY183NGhoOXEzbGpnOWthMDYwdW5tZTNmdWU0OEBn",
            created: "2022-04-08T01:41:42.000Z",
            updated: "2022-04-08T01:41:42.715Z",
            summary: "Testing Event 1",
            creator: CalendarCreator(email: "adam.ha4294@vusd.us", displayName: "Adam Hacker"),
            organizer: CalendarOrganizer(email: "c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com", displayName: "Redwood School Events", organizerSelf: true),
            start: CalendarDate(date: nil, dateTime: "2022-04-22T10:00:00-07:00"),
            end: CalendarDate(date: nil, dateTime: "2022-04-22T16:00:00-07:00"),
            transparency: nil,
            iCalUID: "7h4bs76i26k4oshb2kqi9kk73q@google.com",
            sequence: 0,
            eventType: "default",
            location: "Everyschool High School, 3421 W Everystreet St, Visalia, CA 93292, USA")
        
        ])
}
