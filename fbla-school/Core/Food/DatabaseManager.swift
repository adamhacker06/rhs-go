//
//  DatabaseManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/6/21.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct FoodMemoryCache {
    
    private(set) var foods: [Food]? = nil
    
    func getFoodArray() -> [Food]? {
        if foods != nil {
            return foods
        }
        
        return nil
    }
    
    mutating private func addFood(food: Food) {
        if foods != nil {
            foods!.append(food)
        } else {
            foods = [food]
        }
    }
    
    mutating func addFoodsFromArray(foods: [Food]) {
        for food in foods {
            addFood(food: food)
        }
    }
}

enum WeekDay: String {
    
    init(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        print("DAY IN WEEK \(dayInWeek)")
        
        switch dayInWeek {
        case "Monday":
            self.init(rawValue: "m")!
            
        case "Tuesday":
            self.init(rawValue: "t")!
            
        case "Wednesday":
            self.init(rawValue: "w")!
            
        case "Thursday":
            self.init(rawValue: "th")!
            
        case "Friday":
            self.init(rawValue: "f")!
            
        default:
            self.init(rawValue: "invalid")!
        }
    }
    
    case monday = "m"
    case tuesday = "t"
    case wednesday = "w"
    case thursday = "th"
    case friday = "f"
    case invalid = "invalid"
}

class DatabaseManager: ObservableObject {
    
    var db = Database.database().reference()
    
    @Published var cache = FoodMemoryCache()
    
    func addFoodsToFirebaseFromArray(foods: [Food]) {
        // loop through array calling addFood() for each
    }
    
    private func addFoodToFirebase(food: Food) {
        // write to realtime database AND cache
    }
    
    func fetch(completion: @escaping ([Food]?, Error?) -> Void) {
        
        let cachedFoods = cache.getFoodArray()
        
        if cachedFoods != nil {
            // Return the cached foods if it is not empty
            completion(cachedFoods, nil)
            
        } else {
            fetchFromFirebase(week: .first, day: Date()) { (foods, error) in
                
                if let error = error {
                    completion(nil, error)
                } else {
                    
                    if let foods = foods {
                        self.cache.addFoodsFromArray(foods: foods)
                    }
                    
                    completion(foods, error)
                }
            }
        }
    }
    
    enum FirebaseFoodFetchError: Error {
        case invalidDay
        case invalidData
        case invalidReferenceDate
        case invalidReferenceWeek
    }
    
    func dateFromDashedStringFormat(string: String) -> (Date?, FirebaseFoodFetchError?) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "M-dd-yy"
        
        guard let day = formatter.date(from: string) else { return (nil, FirebaseFoodFetchError.invalidReferenceDate)}
        
        return (day, nil)
    }
    
    func fetchReferenceFoodWeek(completion: @escaping (FoodWeek?, FirebaseFoodFetchError?) -> Void) {
        
        db.child("meta").child("week").observeSingleEvent(of: DataEventType.value) { snapshot in
            
            guard let result = snapshot.value else { completion(nil, .invalidReferenceWeek); return }
            
            if let referenceWeek = FoodWeek(withFirebaseInterpretation: "\(result)") {
                completion(referenceWeek, nil)
                return
            }
            
            completion(nil, FirebaseFoodFetchError.invalidReferenceWeek)
        }
    }
    
    func fetchReference(completion: @escaping (Date?, FirebaseFoodFetchError?) -> Void) {
        db.child("meta").child("ref").observeSingleEvent(of: DataEventType.value) { [weak self] snapshot in
            
            guard let result = snapshot.value else { completion(nil, .invalidReferenceDate); return }
            
            let ref = self?.dateFromDashedStringFormat(string: "\(result)")
            completion(ref?.0, ref?.1)
            
        }
    }
    
    func fetchFromFirebase(week: FoodWeek, day: Date, completion: @escaping ([Food]?, Error?) -> Void) {
        
                if WeekDay.init(date: day) == .invalid {
                    
                    completion(nil, FirebaseFoodFetchError.invalidDay)
                    return
                }
        
        print("Fetching from Firebase...")
        
        db.child("foods").child("\(week.rawValue + 1)").child(WeekDay.init(date: day).rawValue).observe(DataEventType.value) { snapshot in
            
            var foods = [Food]()
            var nextFood = Food()
            
            guard let value = snapshot.value as? Dictionary<String, Dictionary<String, String>> else {
                
                completion(nil, FirebaseFoodFetchError.invalidData)
                return
                
            }
            
            for (foodName, content) in value {
                
                nextFood.name = foodName.capitalized
                
                for (dataType, data) in content {
                    
                    switch dataType {
                        
                    case "ty":
                        nextFood.type = FoodType.init(rawValue: data)
                        
                    case "po":
                        nextFood.portion = data.replacingOccurrences(of: ",", with: ".")
                        
                    case "ca":
                        nextFood.calories = data.replacingOccurrences(of: ",", with: ".") + " kcal"
                        
                    case "s":
                        nextFood.sugars = data.replacingOccurrences(of: ",", with: ".") + " grams"
                        
                    case "pr":
                        nextFood.protein = data.replacingOccurrences(of: ",", with: ".") + " grams"
                        
                    case "cb":
                        nextFood.carbs = data.replacingOccurrences(of: ",", with: ".") + " grams"
                        
                    case "tf":
                        nextFood.transFat = data.replacingOccurrences(of: ",", with: ".") + " grams"
                        
                    default:
                        break
                    }
                }
                
                foods.append(nextFood)
                
            }
            
            completion(foods, nil)
            
        }   
    }
    
    //--//
    
    func getDataFromGitHub(completion: @escaping (Data) -> () ) {
        
        completion(try! Data(contentsOf: URL(string: "https://adamhacker06.github.io/data/food.json")!))
        
    }
    
    func parseFoodData(jsonData: Data) -> [Food] {
        
        let decoder = JSONDecoder()
        
        let foods: [Food] = try! decoder.decode([Food].self, from: jsonData)
        
        return foods
    }
}
