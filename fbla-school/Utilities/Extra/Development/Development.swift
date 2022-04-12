//
//  Development.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import Foundation

class Development {
    static var chickenSandwich = Food(type: .entree, name: "Chicken Sandwich", portion: "1 serving", calories: "390 kcal", sugars: "3.0 grams", protein: "20.0 grams", carbs: "42.0 grams", transFat: "16.5 grams")
    
    static var schedule = ClassSchedule(prefirst: SchoolClass(administrator: "Russell Brown", namePrefix: .mr, title: "Precalcus", email: "rbrown@vusd.org"), first: SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"), second: SchoolClass(administrator: "Russell Brown", namePrefix: .mr, title: "Construction Management", email: "rbown@vusd.org"), third: SchoolClass(administrator: "Javier Quezada", namePrefix: .mr, title: "Math 3 Honors", email: "jquezada@vusd.org"), fourth: SchoolClass(administrator: "Kelli Feehan", namePrefix: .mrs, title: "English 2 Honors", email: "kfeehan@vusd.org"), fifth: SchoolClass(administrator: "Jacob Avila", namePrefix: .mr, title: "Foundations of Business", email: "javila@vusd.org"), sixth: SchoolClass(administrator: "Jonathan Woodbury", namePrefix: .mr, title: "Biology", email: "jwoodbury@vusd.org"))
}
