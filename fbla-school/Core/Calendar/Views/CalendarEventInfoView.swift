//
//  CalendarEventInfoView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/27/22.
//

import SwiftUI

struct CalendarEventInfoView: View {
    
    let event: CalendarItem
    
    var body: some View {
        Text(event.created)
    }
    
}

//struct CalendarEventInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarEventInfoView()
//    }
//}
