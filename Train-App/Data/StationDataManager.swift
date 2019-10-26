//
//  StationDatabaseManager.swift
//  Train-App
//
//  Created by Vicki Larkin on 26/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData

class StationDataManager {
    
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    init(backgroundContext: NSManagedObjectContext = DatabaseManager.shared.backgroundContext, mainContext: NSManagedObjectContext = DatabaseManager.shared.mainContext) {
        self.backgroundContext = backgroundContext
        self.mainContext = mainContext
    }
    
    func createStation(name: String) {
        backgroundContext.performAndWait {
            let station = NSEntityDescription.insertNewObject(forEntityName: Station.description(), into: backgroundContext) as! Station
            station.name = name
            
            try? backgroundContext.save()
        }
    }
    
    func deleteStation(station: Station) {
        let objectID = station.objectID
        backgroundContext.performAndWait {
            if let stationInContext = try? backgroundContext.existingObject(with: objectID) {
                backgroundContext.delete(stationInContext)
                
                try? backgroundContext.save()
            }
        }
    }
    
    func fetchAllStations() -> [Station] {
        let request: NSFetchRequest<Station> = Station.fetchRequest()
        do {
            let results = try mainContext.fetch(request)
            return results
        } catch {
            print("Error fetching results.")
        }
        
        return []
    }
    
    func fetchStationByName(name: String) -> Station? {
        let request: NSFetchRequest<Station> = Station.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try mainContext.fetch(request)
            return result.first
        } catch {
            print("Error fetching results.")
        }
        
        return nil
    }
}
