//
//  LaunchView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/3/21.
//

import SwiftUI



struct LaunchView: View {
    
    @EnvironmentObject var data: DataManager
    
    @Binding var finishedLoading: Bool
    
    @State private var finishedUserDefaultsLoading: Bool = false
    
    @State private var loadingText: [String] = "Loading your info...".map { String($0) }
    @State private var currentCharIndex: Int = 0
    @State private var finishedRotations: Int = 0
    
    let charTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("rhs_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                
            }
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 0) {
                    ForEach(loadingText.indices, id: \.self) { charIndex in
                        Text(loadingText[charIndex])
                            .foregroundColor(.white)
                            .font(.custom("PublicSans-Bold", size: 32))
                            .offset(y: currentCharIndex == charIndex ? -5 : 0)
                        
                    }
                }
                    .offset(y: 80)
            )
        }
        .onReceive(charTimer) { _ in
            timerHandler()
        }
        .onAppear {
            finishedUserDefaultsLoading = foodUserDefaultsHandler() && calendarFetchingHandler() && giganteaFetchingHandler() && scheduleUserDefaultsHandler()
        }
    }
    
    func getCurrentFoodWeek(targetDate: Date, refDate: Date, refFoodWeek: FoodWeek) -> FoodWeek {
        let cal = Calendar(identifier: .gregorian)
        
        let components = cal.dateComponents(
            [.weekOfYear],
            from: cal.date(byAdding: DateComponents(weekday: cal.dateComponents([.weekday], from: refDate).weekday! * -1 + 1, weekOfYear: refFoodWeek == .second ? -1 : 0 ),
                           to: refDate)!,
            to: targetDate)
        
        if components.weekOfYear! % 2 == 0 {
            return(.first)
        } else {
            return(.second)
        }
    }
    
    func foodFetchingHandler() {
        
        // Marks the loading property as "true"
        data.foodDataManager.isUpdating = true
        
        // Make sure to switch date to today
        let targetDate = Date.now
        
        data.database.fetchReference { (refDate, error) in
            if let error = error {
                print(error)
                data.foodDataManager = FoodDataManager(lastUpdated: Date(), foods: nil)
                FoodDataManager.set(manager: data.foodDataManager)
                
                data.foodDataManager.isUpdating = false
                
                return
            }
            
            if let refDate = refDate {
                
                data.database.fetchReferenceFoodWeek { (refWeek, error) in
                    if let error = error {
                        print(error)
                        data.foodDataManager = FoodDataManager(lastUpdated: Date(), foods: nil)
                        FoodDataManager.set(manager: data.foodDataManager)
                        
                        data.foodDataManager.isUpdating = false
                        return
                    }
                    
                    if let refWeek = refWeek {
                        
                        let foodWeek = getCurrentFoodWeek(targetDate:targetDate, refDate: refDate, refFoodWeek: refWeek)
                        
                        print("FOOD WEEK: \(foodWeek)")
                        
                        data.database.fetchFromFirebase(week: foodWeek, day: targetDate) { (food, error) in
                            
                            if let error = error {
                                print(error)
                                data.foodDataManager = FoodDataManager(lastUpdated: Date(), foods: nil)
                                FoodDataManager.set(manager: data.foodDataManager)
                                
                                data.foodDataManager.isUpdating = false
                                return
                            }
                            
                            if let food = food {
                                data.foodDataManager = FoodDataManager(lastUpdated: Date(), foods: food)
                                
                                FoodDataManager.set(manager: data.foodDataManager)
                                data.foodDataManager.isUpdating = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    func foodUserDefaultsHandler() -> Bool {
        
        //        guard let foodManager = FoodUserDefaultsManager.get() else {
        //
        //            fetchingHandler()
        //
        //            return true
        //
        //        }
        //
        //        if (foodManager.lastUpdated.asLongDateString() == Date().asLongDateString()) && (foodManager.foods != nil) {
        //
        //            data.foodDataManager = foodManager
        //
        //            return true
        //
        //        }
        
        foodFetchingHandler()
        
        return true
        
    }
    
    func calendarFetchingHandler() -> Bool {
        
        data.calendarDataManager.isUpdating = true
        
        CalendarAPIManager.sendPublicGETRequest() { (calendar, error) in
            
            guard let calendar = calendar else {
                
                if let error = error {
                    print("ERROR :\(error.localizedDescription)")
                } else {
                    print("Unknown error occured when fetching calendar data")
                }

                data.calendarDataManager.isUpdating = false
                return
            }

            data.calendarDataManager = CalendarDataManager(lastUpdated: Date(), calendar: calendar)
            
            data.calendarDataManager.isUpdating = false
            
        }
        
        return true
    }
    
    func giganteaFetchingHandler() -> Bool {
        
        GiganteaNetworkManager.subscribeToData { articleData in
            
            let parser = ArticlesParser(data: articleData)
            var articleStore: [Article] = []
            
            if parser.parse() {
                
                for i in parser.articles.indices {
                    
                    let paragraphsParser = HTMLasXMLContentParser(data: parser.articles[i].htmlContent.asXMLDatafromString())
                    
                    if paragraphsParser.parse() {
                        parser.articles[i].paragraphContent = paragraphsParser.paragraphs
                    }
                    
                    articleStore.append(parser.articles[i])

                }
             
                data.giganteaDataManager = GiganteaDataManager(lastUpdated: Date(), gigantea: GiganteaModel(articles: articleStore))
                
            }
        }
        
        return true
    }
    
    func featuredExtraCurricularsFetchingHandler() -> Bool {
        
        data.extracurricularsDataManager.cache.get(contentsOf: .featured) { (extracurriculars, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
            } else {
                if let extracurriculars = extracurriculars {
                    
                    data.extracurricularsDataManager.cache.set(items: extracurriculars, for: .featured)
                    
                }
            }
        }
        
        return true
    }
    
    func scheduleUserDefaultsHandler() -> Bool {
        guard var scheduleDataManager = ScheduleDataManager.get() else { return true }
        
        scheduleDataManager.cache = SchoolClassesCache()
        data.scheduleDataManager = scheduleDataManager
        
        return true
        
    }
    
    //    func calendarJSONDecoder() -> GoogleAPICalendar {
    //
    //    }
    
    func timerHandler() {
        withAnimation {
            
            if finishedRotations > 1 && finishedUserDefaultsLoading {
                withAnimation { finishedLoading = true }
            }
            
            if currentCharIndex > loadingText.count - 1 {
                
                currentCharIndex = 0
                finishedRotations += 1
                
            } else {
                
                currentCharIndex += 1
                
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(finishedLoading: .constant(false))
            .environmentObject(DataManager())
    }
}
