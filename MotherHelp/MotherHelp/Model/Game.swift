//
//  Game.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

enum TypeOfGame: String {
    case alpha = "Alpha (A-Z)"
    case numeric = "Numeric (1-24)"
    case sound = "Sons ([a], [i]...)"
    case form = "Forme géométrique"
}

final class Game {
    
    // MARK: - Properties
    
    static var list = [Game]()
    var name: String
    var domain: String
    var effectuate = [String: Bool]()
    
    // MARK: - Initializer
    
    init(name: String, domain: String, typeOfGame: TypeOfGame) {
        self.name = name
        self.domain = domain
        self.effectuate = initEffectuate(with: typeOfGame)
    }
    
    init(withCoreData game: GameEntity) {
        var effectuatedGame = [String: Bool]()
        for key in game.type! {
            effectuatedGame.updateValue(false, forKey: key)
        }
        self.name = game.name!
        self.domain = game.domain!
        self.effectuate = effectuatedGame
    }
    
    // MARK: - Private method
    
    private func initEffectuate(with choice: TypeOfGame) -> [String: Bool] {
        let sound = ["[a]", "[i]", "[o]", "[u]", "[e]", "[l]", "[r]", "[m]", "[f]", "[v]", "[n]", "[j]", "[ch]", "[s]", "[z]", "[p]", "[d]", "[k]", "[g]", "[b]", "[t]"]
        var dictionary = [String: Bool]()
        switch choice {
        case .alpha:
            for code in 97...122 {
                dictionary.updateValue(false, forKey: String(UnicodeScalar(code)!))
            }
        case .numeric:
            for code in 1...24 {
                dictionary.updateValue(false, forKey: "\(code)")
            }
        case .sound:
            for code in 0...20 {
                dictionary.updateValue(false, forKey: sound[code])
            }
        case .form:
            dictionary.updateValue(false, forKey: "carré")
            dictionary.updateValue(false, forKey: "étoile")
            dictionary.updateValue(false, forKey: "losange")
            dictionary.updateValue(false, forKey: "triangle")
            dictionary.updateValue(false, forKey: "rond")
        }
        return dictionary
    }
}
