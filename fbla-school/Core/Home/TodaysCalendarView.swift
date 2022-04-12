//
//  TodaysCurrentCalendarView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 12/31/21.
//

import SwiftUI

struct TodaysCalendarView: View {
    
    @Binding var calendarDataManager: CalendarDataManager
    //    @Binding var calendar: GoogleAPICalendar?
    @Binding var isUpdating: Bool
    
    @State private var showAllCalendarEvents: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            if let calendar = calendarDataManager.calendar {
                VStack(spacing: 5) {
                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        
                        Text("Upcoming Events")
                            .font(.custom("PublicSans-SemiBold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        if calendar.items.count != 0 {
                            Text("See all")
                                .underline()
                                .foregroundColor(.white)
                                .font(.custom("PublicSans-Regular", size: 16))
                                .onTapGesture {
                                    showAllCalendarEvents = true
                                }
                        }
                    }
                    
                    CustomDivider(color: .white, thickness: 5)
                }
                .background {
                    NavigationLink("", isActive: $showAllCalendarEvents) {
                        AllCalendarEventsView(calendar: calendar)
                    }
                }
                
                // Calendar Items below
                VStack(alignment: .leading, spacing: 15) {
                    
                    if calendar.items.isEmpty {
                        Text("There are no upcoming events. Check back later!")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                    } else {
                        
                        ForEach(calendar.items.indices[..<( calendar.items.count <= 3 ? calendar.items.count : 3 ) ] , id: \.self) { index in
                            
                            let event = calendar.items[index]
                            
                            // Tile View
                            CalendarEventTileView(eventIndex: index, event: event)
                            
                        }
                    }
                    
                }
                
                Text("Retrieved with Google Calendar")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.custom("PublicSans-Regular", size: 16))
                    .foregroundColor(Color.theme.white)
                    .padding(.vertical)
                
            } else {
                
                VStack(spacing: 5) {
                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        
                        Text("Upcoming Events")
                            .font(.custom("PublicSans-SemiBold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                    }
                    
                    CustomDivider(color: .white, thickness: 5)
                }
                
                if isUpdating {
                    ProgressView()
                        .foregroundColor(Color.white)
                } else {
                    HStack {
                        Text("Please check your internet connection.")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Button(action : {
                            
                            calendarDataManager.isUpdating = true
                            
                            CalendarAPIManager.sendPublicGETRequest() { (calendar, error) in
                                
                                guard let calendar = calendar else {
                                    
                                    if let error = error {
                                        print("ERROR :\(error.localizedDescription)")
                                    } else {
                                        print("Unknown error occured when fetching calendar data")
                                    }
                                    
                                    calendarDataManager.isUpdating = false
                                    return
                                }
                                
                                calendarDataManager = CalendarDataManager(lastUpdated: Date(), calendar: calendar)
                                
                                calendarDataManager.isUpdating = false
                                
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 15)
//        .padding(.bottom, 18)
        .background(Color.theme.darkGreen)
        .cornerRadius(10)
    }
}

extension TodaysCalendarView {
    func getEventsFromStart(calendar: GoogleAPICalendar, amount: Int) -> [CalendarItem] {
        Array(calendar.items[0...(amount - 1)])
    }
}

//struct TodaysCurrentCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodaysCalendarView(calendarDa: .constant(GoogleAPICalendar(kind: "", etag: "", summary: "", updated: "", timeZone: "", accessRole: "", defaultReminders: [], nextSyncToken: nil, nextPageToken: nil, items: [
//
//            CalendarItem(kind: "", etag: "", id: "", status: "", htmlLink: "", created: "", updated: "", summary: "Football Game", creator: CalendarCreator(email: "", displayName: ""), organizer: CalendarOrganizer(email: "", displayName: "", organizerSelf: false), start: CalendarDate(date: "", dateTime: nil), end: CalendarDate(date: "", dateTime: nil), transparency: nil, iCalUID: "", sequence: 1, eventType: "", location: "Redwood High School")
//
//        ])), isUpdating: .constant(false))
//    }
//}
