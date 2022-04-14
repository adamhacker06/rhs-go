//
//  GiganteaUserDefaultsManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/27/22.
//

import Foundation
import Combine

struct GiganteaDataManager: Codable {
    
    static func get() -> GiganteaDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "giganteaManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(GiganteaDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: GiganteaDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "giganteaManager")
        }
    }
    
    var lastUpdated: Date
    var gigantea: GiganteaModel?

}

struct GiganteaNetworkManager {
    var cancellable: AnyCancellable?
    private static let sessionProcessingQueue = DispatchQueue(label: "GiganteaSessionProcessingQueue")
    
    static func subscribeToData(completion: @escaping (Data) -> Void) {
        
        let url = URL(string: "https://redwoodgigantea.com/feed/")!
        
        let _ = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: sessionProcessingQueue)
            .map({
                return $0.data
            })
            .receive(on: DispatchQueue.main)
            .sink { (subscriberCompletion) in
                switch subscriberCompletion {
                case .finished:
                    // do something that you want to do when finished
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            } receiveValue: { data in
                completion(data)
            }
    }
}
