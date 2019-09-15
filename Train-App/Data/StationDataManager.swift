//
//  StationDataManager.swift
//  Train-App
//
//  Created by Vicki Larkin on 15/09/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData
import Foundation

class StationDataManager {
    
    let backgroundContext: NSManagedObjectContext
    
    init(backgroundContext: NSManagedObjectContext = DatabaseManager.shared.backgroundContext) {
        self.backgroundContext = backgroundContext
    }
    
    // MARK: - Create
    func createStation(name: String) {
        backgroundContext.performAndWait {
            let station = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: backgroundContext) as! StationDB
            station.name = name
            
            try? backgroundContext.save()
        }
    }
    
    // MARK: - Fetch
    func fetchAllStations() -> [StationDB] {
        let fetchRequest = NSFetchRequest<StationDB>.init(entityName: StationDB.description())
        
        do {
            let fetchedStations = try backgroundContext.fetch(fetchRequest)
            return fetchedStations
        } catch {
            print("Error fetching stations: \(error)")
        }
        
        return []
    }
    
    // MARK: - Delete
    func deleteStation(station: StationDB) {
        let objectId = station.objectID
        backgroundContext.performAndWait {
            if let stationInContext = try? backgroundContext.existingObject(with: objectId) {
                backgroundContext.delete(stationInContext)
            }
            
            try? backgroundContext.save()
        }
    }
}
