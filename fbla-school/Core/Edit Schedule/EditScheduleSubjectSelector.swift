//
//  EditScheduleClassSelector.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import SwiftUI

enum Subjects: String, Identifiable, CaseIterable {
    case ASB = "ASB"
    case academies = "Academies"
    case CTE = "CTE"
    case english = "English"
    case foreignLanguage = "Foreign Language"
    case math = "Math"
    case PE = "PE"
    case science = "Science"
    case socialScience = "Social Science"
    case specialEduation = "Special Education"
    case visualAndPerformingArts = "Visual and Performing Arts"
    case other = "Other"
    
    var id: Self { self }
    
    var emoji: String {
        switch self {
            
        case .ASB:
            return "🧑‍⚖️"
            
        case .academies:
            return "👷"
            
        case .CTE:
            return "👨‍💼"
            
        case .english:
            return "📚"
            
        case .foreignLanguage:
            return "🇪🇸"
            
        case .math:
            return "📐"
            
        case .PE:
            return "🏃‍♀️"
            
        case .science:
            return "🧪"
            
        case .socialScience:
            return "📜"
            
        case .specialEduation:
            return "🤝"
            
        case .visualAndPerformingArts:
            return "🎭"
            
        case .other:
            return ""
        }
    }
    var description: String {
        switch self {
            
        case .ASB:
            return "The Associated Student Body, for those who help keep our school together."
            
        case .academies:
            return "Calling all future engineers and laywers! For those enrolled in a Linked Learning Academy."
            
        case .CTE:
            return "Career Technical Education classes, everything from business to agriculture."
            
        case .english:
            return "Book, books, and more books! For those with a passion of reading."
            
        case .foreignLanguage:
            return "Learn to communicate with others through Spanish, French, and ASL."
            
        case .math:
            return "The Universal Language. For those learning the dance of the numbers."
            
        case .PE:
            return "Prepare to burn some calories with Physical Education."
            
        case .science:
            return "Chemistry, Biology and more. Learn the building blocks of life itself."
            
        case .socialScience:
            return "Past and present alike, learn how society runs and functions."
            
        case .specialEduation:
            return "Math, English, and Life classes that are accessible to all."
            
        case .visualAndPerformingArts:
            return "Fire up the band! Set the stage! Get ready for creativity to flow free."
            
        case .other:
            return "AVID, Yearbook, and more."
        }
    }
}

struct SchoolSubjectItemView: View {
    
    let associatedEnum: Subjects
    
    var body: some View {
        HStack(alignment: .top) {
        
            Text(associatedEnum.emoji)
                .padding()
                .shadow(radius: 5)
                .font(.largeTitle)
                .frame(maxWidth: 70, maxHeight: 70)
                .overlay(
                    Circle().stroke(Color.theme.lapiz, lineWidth: 2)
                )
            
            Spacer(minLength: 30)
            
            VStack(alignment: .trailing, spacing: 0) {
                Text(associatedEnum.rawValue)
                    .font(.custom("PublicSans-Bold", size: 18))
                    .foregroundColor(Color.theme.lapiz)
                
                Text(associatedEnum.description)
                    .font(.custom("PublicSans-Light", size: 14))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct EditScheduleSubjectSelector: View {
    
    @EnvironmentObject var data: DataManager
    
    var classPeriod: ClassPeriod
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(Subjects.allCases) { subjectEnum in
                    SchoolSubjectItemView(associatedEnum: subjectEnum)
                        .padding()
                }
            }
        }
    }
}

struct EditScheduleClassSelector_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleSubjectSelector(classPeriod: .first)
    }
}
