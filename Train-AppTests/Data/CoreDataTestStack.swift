//
//  CoreDataTestStack.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 15/09/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData
import Foundation
import XCTest
@testable import Train_App

class CoreDataTestStack {
    
    let persistentContatiner: NSPersistentContainer
    let backgroundContext: NSManagedObjectContextSpy
    let mainContext: NSManagedObjectContextSpy
    
    init() {
        persistentContatiner = NSPersistentContainer(name: "Train_App")
        let description = persistentContatiner.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        persistentContatiner.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = NSManagedObjectContextSpy(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = persistentContatiner.persistentStoreCoordinator
        
        backgroundContext = NSManagedObjectContextSpy(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}

class NSManagedObjectContextSpy: NSManagedObjectContext {
    
    var expectation: XCTestExpectation?
    var saveWasCalled = false
    
    override func performAndWait(_ block: () -> Void) {
        super.performAndWait(block)
        expectation?.fulfill()
    }
    
    override func save() throws {
        try super.save()
        saveWasCalled = true
    }
}
