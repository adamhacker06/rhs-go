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
        
        VStack(spacing: 0) {
            
            // header
            HStack(alignment: .top) {
                VStack(alignment: .leading,  spacing: 3) {
                    
                    Text("Upcoming Events")
                        .bold()
                        .font(.publicSans, weight: .medium, size: 18)
                    
                    Text("As of \(Date.now.asShortDateString())")
                        .font(.publicSans, weight: .regular, size: 16)
                    
                }
                .foregroundColor(.white)
                .font(.custom("PublicSans-Bold", size: 20))
                
                Spacer()
                
                VStack(spacing: 0) {
                    // see all button
                    
                    if let calendar = calendarDataManager.calendar {
                        if calendar.items.count > 3 {
                            Button(action: { showAllCalendarEvents = true }) {
                                Text("See all")
                                    .foregroundColor(.white)
                                    .font(.publicSans, weight: .regular, size: 16)
                                    .underline()
                            }
                            .background (
                                
                                NavigationLink("", isActive: $showAllCalendarEvents) {
                                    AllCalendarEventsView(calendar: calendar)
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                }
                                
                            )
                        }
                    }
                }
            }
            .padding()
            .background(
                
                Color.theme.darkGreen
                
            )
            
            
            // body
            VStack(spacing: 20) {
                
                if let calendar = calendarDataManager.calendar {
                    
                    ForEach(calendar.items.indices[..<( calendar.items.count <= 3 ? calendar.items.count : 3 ) ] , id: \.self) { index in
                        
                        let event = calendar.items[index]
                        
                        // Tile View
                        CalendarEventTileView(eventIndex: index, event: event)
                        
                    }
                    
                } else {
                    Text("Unable to load events")
                }
            }
            .padding([.horizontal, .bottom])
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
}

extension TodaysCalendarView {
    func getEventsFromStart(calendar: GoogleAPICalendar, amount: Int) -> [CalendarItem] {
        Array(calendar.items[0...(amount - 1)])
    }
}

struct TodaysCurrentCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color.init(hex: 0xf5f5f5).ignoresSafeArea()
            
            TodaysCalendarView(calendarDataManager: .constant(Development.calendarDataManager), isUpdating: .constant(false))
                .padding(.horizontal, 20)
        }
    }
}
