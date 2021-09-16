//
//  DatabaseManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/6/21.
//

import Foundation
import FirebaseDatabase

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

class DatabaseManager: ObservableObject {
    
    static let shared = DatabaseManager()
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
            fetchFromFirebase { (foods, error) in
          
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
    
    func fetchFromFirebase(completion: @escaping ([Food]?, Error?) -> Void) {
        print("Fetching from Firebase...")
        db.child("foods").observe(.value, with: { snapshot in
            
            var foods = [Food]()
            var nextFood = Food()
            
            let value = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            
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
            
        }) { error in
            print(error.localizedDescription)
            completion(nil, error)
        }
    }
}
