//
//  MockDatabaseManager.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 24/01/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import CoreData
import Foundation
import XCTest

class MockDatabaseManager {
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Train_App")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("unable to load store due to error: \(error)")
            }
            
        }
        
        backgroundContext = self.persistentContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mainContext = self.persistentContainer.viewContext
        mainContext.automaticallyMergesChangesFromParent = true
        
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

