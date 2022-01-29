//
//  EditScheduleClassSelector.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import SwiftUI

extension SchoolSubjectItem.Subjects: Identifiable {
    var id: Self { self }
}

struct SchoolSubjectItem {
    
    enum Subjects: String, CaseIterable {
        case ASB = "ASB"
        case academies = "Academies"
        case CTE = "CTE"
        case english = "English"
        case foreignLanguage = "Foreign Language"
        case math = "Math"
        case other = "Other"
        case PE = "PE"
        case science = "Science"
        case socialScience = "Social Science"
        case specialEduation = "Special Education"
        case visualAndPerformingArts = "Visual and Performing Arts"
        
        
        // future adam: make list
    }
    
    let associatedEnum: SchoolSubjectItem.Subjects
    let emoji: String
    let description: String
    
}

struct EditScheduleSubjectSelector: View {
    
    @EnvironmentObject var data: DataManager
    
    var classPeriod: ClassPeriod
    
    var body: some View {
        VStack {
            ForEach(SchoolSubjectItem.Subjects.allCases) { subjectEnum in
                
            }
        }
    }
}

struct EditScheduleClassSelector_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleSubjectSelector(classPeriod: .first)
    }
}
