//
//  StationDatabaseManager.swift
//  Train-App
//
//  Created by Vicki Larkin on 26/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData

class StationDataManager {

    private let mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = DatabaseManager.shared.mainContext, backgroundContext: NSManagedObjectContext = DatabaseManager.shared.backgroundContext) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
    
    func createStation(name: String) {
        backgroundContext.performAndWait {
            let station = NSEntityDescription.insertNewObject(forEntityName: Station.description(), into: backgroundContext) as! Station
            station.name = name
            
            save(to: backgroundContext)
        }
    }
    
    func deleteStation(station: Station) {
        let objectID = station.objectID
        backgroundContext.performAndWait {
            if let stationInContext = try? backgroundContext.existingObject(with: objectID) {
                backgroundContext.delete(stationInContext)
                
                save(to: backgroundContext)
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

// MARK: - Private methods

extension StationDataManager {
    
    private func save(to context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
    }
    
}
