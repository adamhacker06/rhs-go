//
//  CalendarEventTileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/27/22.
//

import SwiftUI

struct CalendarEventTileView: View {
    
    let eventIndex: Int
    let event: CalendarItem
    
    var body: some View {
        
        HStack(spacing: 5) {
            
            HStack(spacing: 10) {
                
                if let allDayEventDateString = event.start.date {
                    Text(allDayEventDateString.toDate(format: .yyyyMMdd).asShortDateString())
                        .font(.custom("PublicSans-Medium", size: 20))
                        .foregroundColor(Color.white)
                } else {
                    if let dateString = event.start.dateTime {
                        Text(dateString.toDate(format: .RFC3339).asShortDateString())
                            .font(.custom("PublicSans-Medium", size: 20))
                            .foregroundColor(Color.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(event.summary)
                        .font(.custom("PublicSans-Medium", size: 16))
                        .foregroundColor(Color.white)
                    
                    if let location = event.location {
                        Text(location.toShortLocationForm())
                            .font(.custom("PublicSans-Light", size: 13))
                            .foregroundColor(Color.white)
                    }
                }
            }
            
            Spacer(minLength: 10)
            
            if let dateString = event.start.dateTime {
                Text(dateString.toDate(format: .RFC3339).asShortTimeString(showAMPM: true))
                    .font(.custom("PublicSans-Light", size: 16))
                    .foregroundColor(Color.white)
            }
            
        }
        .padding(.vertical, eventIndex % 2 == 0 ? 5 : 0)
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background (
            
            Color.theme.darkerGreen.cornerRadius(5)
                .opacity(eventIndex % 2 == 0 ? 1 : 0)
            
        )
        .padding(.top, eventIndex == 0 ? 18 : 0)
        
    }
    
}

//struct CalendarEventTileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarEventTileView(eventIndex: 0, event: CalendarItem()
//    }
//}
