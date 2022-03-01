//
//  SubjectsEnum.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/6/22.
//

import Foundation

protocol ContentSubType: CustomLabelInformation {
    
    var name: String { get }
    
}

enum SubjectsEnum: String, ContentSubType, CustomLabelInformation, Identifiable, CaseIterable {
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
    var name: String {
        return self.rawValue
    }
}

enum FacultyTypesEnum: String, ContentSubType, CustomLabelInformation, Identifiable, CaseIterable {
    case administration = "administration"
    case counselors = "counselors"
    
    var id: Self { self }
    
    var emoji: String {
        switch self {
        case .administration:
            return "👨‍💼"
        case .counselors:
            return "A-Z"
        }
    }
    
    var description: String {
        return ""
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
    
}

enum MessageContentTypes: String, CustomLabelInformation, Identifiable, CaseIterable {
    
    case schoolClass = "Classes"
    case faculty = "Staff"
    case extracurricular = "Extracurriculars"
    
    var id: Self { self }
    
    var emoji: String {
        switch self {
        case .schoolClass:
            return "📚"
        case .faculty:
            return "🧑‍💼"
        case .extracurricular:
            return "🎨"
        }
    }
    
    var description: String {
        switch self {
        case .schoolClass:
            return "Message a teacher from any class on campus"
        case .faculty:
            return "Message a member of our adminsitration team"
        case .extracurricular:
            return "Message the advisor or teacher of an extracurriular program"
        }
    }
    
    var name: String {
        self.rawValue
    }
    
    }
    


