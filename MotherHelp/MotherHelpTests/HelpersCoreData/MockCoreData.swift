//
//  MockCoreData.swift
//  MotherHelpTests
//
//  Created by Jérôme Guèrin on 18/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation
import MotherHelp
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "MotherHelp")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
