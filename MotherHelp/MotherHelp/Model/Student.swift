//
//  Student.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation
    
final class Student {
    
    // MARK: - Properties
    
    static var list = [Student]()
    var name: String
    var games: [String: [String:Bool]]
    
    // MARK: - Initializer
    
    init(name: String, games: [String: [String:Bool]]) {
        self.name = name
        self.games = games
    }
    
    init(withCoreData student: StudentEntity) {
        self.name = student.name!
        self.games = student.games!
    }
    
    // MARK: - Method
    
    func isTheGameDone(named name: String, atIndex level: String, _ bool: Bool) {
        if games[name] != nil {
            if games[name]![level] != nil {
                games[name]![level] = bool
            }
        }
    }
    
    func addingGame(named game: Game) {
        //games.updateValue(game.effectuate, forKey: game.name)
        games[game.name] = game.effectuate
    }
}
