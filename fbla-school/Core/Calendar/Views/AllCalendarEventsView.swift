//
//  AllCalendarEventsView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/27/22.
//

import SwiftUI

struct AllCalendarEventsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let calendar: GoogleAPICalendar
    
    var body: some View {
        VStack(spacing: 0) {
            
            headerComponents
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    ForEach(calendar.items) { event in
                        
                        AllCalendarEventsTileView(event: event)
                            .padding(.horizontal, 20)
                        
                    }
                }
                .padding(.vertical, 20)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
}

private struct AllCalendarEventsTileView: View {
    
    let event: CalendarItem
    
    var body: some View {
        
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(event.summary)
                    .font(.custom("PublicSans-Bold", size: 20))
                
                if let location = event.location {
                    Text(location)
                        .font(.custom("PublicSans-Medium", size: 16))
                }
                
                HStack(spacing: 0) {
                    
                    if event.start.date != nil {
                        
                        Text("All Day Event")
                        
                    } else {
                        if let startDateString = event.start.dateTime {
                            Text(startDateString.toDate(format: .RFC3339).asShortTimeString(showAMPM: true))
                        } else {
                            Text("Unknown")
                        }
                        
                        Text(" - ")
                        
                        if let endDateString = event.end.dateTime {
                            Text(endDateString.toDate(format: .RFC3339).asShortTimeString(showAMPM: true))
                        } else {
                            Text("Unknown")
                        }

                    }
                    
                    Spacer()
                    
                    if let allDayEventDateString = event.start.date {
                        Text(allDayEventDateString.toDate(format: .yyyyMMdd).asShortDateString())
                            .font(.custom("PublicSans-Medium", size: 20))
                    } else {
                        if let dateString = event.start.dateTime {
                            Text(dateString.toDate(format: .RFC3339).asShortDateString())
                                .font(.custom("PublicSans-Medium", size: 20))
                        }
                    }
                    
                }
                .font(.custom("PublicSans-Regular", size: 16))
                .padding(.top)
            }
            .foregroundColor(Color.white)
            
            Spacer()
            
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(Color.theme.darkerGreen, lineWidth: 1)
                .background(Color.theme.darkGreen.cornerRadius(15))
        )

        
        
    }
}

extension AllCalendarEventsView {
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("All Calendar Events")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.darkerGreen.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
}

//struct AllCalendarEventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCalendarEventsView(calendar: GoogleAPICalendar()
//    }
//}
