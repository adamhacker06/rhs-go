//
//  TodaysCurrentCalendarView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 12/31/21.
//

import SwiftUI

struct TodaysCurrentCalendarView: View {
    
    @Binding var calendar: GoogleAPICalendar?
    
    @State private var showAllCalendarEvents: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            if let calendar = calendar {
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
                                .font(.custom("PublicSans-Normal", size: 16))
                                .onTapGesture {
                                    showAllCalendarEvents = true
                                }
                                .onAppear {
                                    print(calendar.items.count)
                                }
                        }
                    }
                    
                    CustomDivider(color: .white, thickness: 5)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    if let events = calendar.items {
                        ForEach(events.indices, id: \.self) { index in
                            let event = events[index]
                            // Add Tile View for Calendar
                            
                            HStack(spacing: 5) {
                                
                                HStack(spacing: 10) {
                                    
                                    if let dateString = event.start.dateTime {
                                        Text(dateString.toDate(format: .RFC3339).asShortDateString())
                                            .font(.custom("PublicSans-Medium", size: 20))
                                            .foregroundColor(Color.theme.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(event.summary)
                                            .font(.custom("PublicSans-Medium", size: 16))
                                            .foregroundColor(Color.theme.white)
                                        
                                        if let location = event.location {
                                            Text(location.toShortLocationForm())
                                                .font(.custom("PublicSans-Light", size: 13))
                                                .foregroundColor(Color.theme.white)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                if let dateString = event.start.dateTime {
                                    Text(dateString.toDate(format: .RFC3339).asShortTimeString(showAMPM: true))
                                        .font(.custom("PublicSans-Light", size: 16))
                                        .foregroundColor(Color.theme.white)
                                }
                                    
                               
                                
                            }
                            .padding(.vertical, index % 2 == 0 ? 5 : 0)
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background (
                                
                                Color.theme.darkerGreen.cornerRadius(5)
                                    .opacity(index % 2 == 0 ? 1 : 0)
                                
                            )
                            
                        }
                    } else {
                        Text("Unable to get calendar events")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                    }
                }
            } else {
                Text("Unable to load calendar")
                    .foregroundColor(Color.theme.white)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 15)
        .padding(.bottom, 18)
        .background(Color.theme.darkGreen)
        .cornerRadius(10)
    }
}

extension TodaysCurrentCalendarView {
    func getEventsFromStart(calendar: GoogleAPICalendar, amount: Int) -> [CalendarItem] {
        Array(calendar.items[0...(amount - 1)])
    }
}

struct TodaysCurrentCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysCurrentCalendarView(calendar: .constant(GoogleAPICalendar(kind: "", etag: "", summary: "", updated: "", timeZone: "", accessRole: "", defaultReminders: [], nextSyncToken: nil, nextPageToken: nil, items: [
            
            CalendarItem(kind: "", etag: "", id: "", status: "", htmlLink: "", created: "", updated: "", summary: "Football Game", creator: CalendarCreator(email: "", displayName: ""), organizer: CalendarOrganizer(email: "", displayName: "", organizerSelf: false), start: CalendarDate(date: "", dateTime: nil), end: CalendarDate(date: "", dateTime: nil), transparency: nil, iCalUID: "", sequence: 1, eventType: "", location: "Redwood High School")
            
        ])))
    }
}
