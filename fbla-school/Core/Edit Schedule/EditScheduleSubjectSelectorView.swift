//
//  EditScheduleClassSelector.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import SwiftUI

enum SubjectsEnum: String, Identifiable, CaseIterable {
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

struct EditScheduleFooterCompartmentSizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct EditScheduleSubjectSelectorView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var childPaddingSize: CGFloat = .zero
    
    var classPeriod: ClassPeriod
    
    var body: some View {
        ZStack {
            
            NavigationView {
                ScrollView {
                    ForEach(SubjectsEnum.allCases) { subjectEnum in
                        SchoolSubjectItemView(associatedSubjectEnum: subjectEnum, childPaddingAmount: $childPaddingSize)
                            .padding()
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            
            VStack {
                
                Spacer()
                
                HStack {
                    
//                    Image(systemName: "xmark")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.theme.darkRed)
//
//                    Spacer()
                    
                    Text("Editing Period \(classPeriod.rawValue)")
                        .font(.custom("PublicSans-Bold", size: 24))
                        .foregroundColor(Color.theme.white)
                    
//                    Spacer()
//
//                    Image(systemName: "checkmark")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.theme.darkGreen)
//
                    
                }
                .padding()
                .background {
                    GeometryReader { proxy in
                        Color.theme.lapiz.cornerRadius(10)
                            .preference(key: EditScheduleFooterCompartmentSizePreferenceKey.self, value: proxy.size.height)
                            .onPreferenceChange(EditScheduleFooterCompartmentSizePreferenceKey.self) { preferences in
                                childPaddingSize = preferences
                            }
                    }
                }
                .padding()
                .shadow(radius: 10)
                
            }
        }
    }
}

struct EditScheduleClassSelector_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleSubjectSelectorView(classPeriod: .first)
            .environmentObject(DataManager())
    }
}
