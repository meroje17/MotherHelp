//
//  CoreDataManager.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var students: [StudentEntity] {
        let request: NSFetchRequest<StudentEntity> = StudentEntity.fetchRequest()
        guard let students = try? managedObjectContext.fetch(request) else { return [] }
        return students
    }
    
    var games: [GameEntity] {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        guard let games = try? managedObjectContext.fetch(request) else { return [] }
        return games
    }
    
    var domains: [DomainEntity] {
        let request: NSFetchRequest<DomainEntity> = DomainEntity.fetchRequest()
        guard let domains = try? managedObjectContext.fetch(request) else { return [] }
        return domains
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func create(student: Student) {
        let studentEntity = StudentEntity(context: managedObjectContext)
        studentEntity.name = student.name
        studentEntity.games = student.games
        coreDataStack.saveContext()
    }
    
    func create(game: Game) {
        let gameEntity = GameEntity(context: managedObjectContext)
        var type = [String]()
        for (key, _) in game.effectuate {
            type.append(key)
        }
        gameEntity.name = game.name
        gameEntity.domain = game.domain
        gameEntity.type = type
        coreDataStack.saveContext()
    }
    
    func update(student: Student) {
        students.forEach { if $0.name == student.name { $0.games = student.games } }
        coreDataStack.saveContext()
    }
    
    func create(domain: Domain) {
        let domainEntity = DomainEntity(context: managedObjectContext)
        domainEntity.name = domain.name
        coreDataStack.saveContext()
    }

    func deleteStudent(named name: String) {
        students.forEach { if $0.name == name { managedObjectContext.delete($0) } }
        coreDataStack.saveContext()
    }
    
    func deleteGame(named name: String) {
        games.forEach { if $0.name == name { managedObjectContext.delete($0) } }
        coreDataStack.saveContext()
    }
    
    func deleteDomain(named name: String) {
        domains.forEach { if $0.name == name { managedObjectContext.delete($0) } }
        coreDataStack.saveContext()
    }
}
