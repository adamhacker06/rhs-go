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
                            Text("See more")
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
                            
                            // Add Tile View for Calendar
                            Text(events[index].summary)
                                
                        }
                    } else {
                        Text("Unable to get calendar events")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                    }
                }
            } else {
                Text("Unable to load calendar")
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

//struct TodaysCurrentCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodaysCurrentCalendarView(calendar: .constant(GoogleAPICalendar(kind: "", etag: "", summary: "", updated: "", timeZone: "", accessRole: "", defaultReminders: [], nextSyncToken: "", events: [Event(kind: "", etag: "", id: "", status: "", htmlLink: "", created: "", updated: "", summary: "Test", creator: Creator(email: "", displayName: ""), organizer: Organizer(email: "", displayName: "", organizerSelf: ""), start: "", end: "", transparency: "", iCalUID: "", sequence: "", eventType: "")])))
//    }
//}
