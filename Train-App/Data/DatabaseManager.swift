//
//  DatabaseManager.swift
//  Train-App
//
//  Created by Vicki Larkin on 15/09/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData
import Foundation

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private var storeType: String!
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "Train_App")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = storeType
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    // MARK: - SetUp
    func setup(storeType: String = NSSQLiteStoreType ,completion: (() -> Void)?) {
        self.storeType = storeType
        loadPersistentStore {
            completion?()
        }
    }
    
    // MARK: - Loading
    private func loadPersistentStore(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unagle to load store \(error!)")
            }
            completion()
        }
    }
}
