//
//  YourDayView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/28/21.
//

import SwiftUI

struct YourDayView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Your Day")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.custom("PublicSans-SemiBold", size: 18))
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
            }
            
            CustomDivider(color: .theme.lightBlue, thickness: 5)
                .padding(.top, 5)
            
            VStack(spacing: 0) {
                ForEach(1..<7) { classPeriod in
                    ClassOverView(classPeriod: ClassPeriod(rawValue: classPeriod)!)
                        .padding(.top, 18)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 15)
        .padding(.bottom, 18)
        .background(Color.theme.lapiz)
        .cornerRadius(10)
        .padding(20)
        
        
    }
}

struct ClassOverView: View {
    
    var classPeriod: ClassPeriod
    
    var body: some View {
        HStack(spacing: 0) {
            Text(classPeriod.getTime(for: .starting))
                .font(.custom("PublicSans-SemiBold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Spanish 2")
                    .foregroundColor(.theme.lapiz)
                    .font(.custom("PublicSans-SemiBold", size: 14))
                
                Text("Room 8")
                    .font(.custom("PublicSans-Regular", size: 9))
                
            }
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color.white)
            .cornerRadius(5)
        }
    }
}

struct YourDayView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            YourDayView()
        }
    }
}
