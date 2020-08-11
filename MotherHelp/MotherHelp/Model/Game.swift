//
//  Game.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Game {
    
    // MARK: - Properties
    
    var name: String
    var domain: String
    var effectuate: [String: Bool]
    
    // MARK: - Initializer
    
    init(name: String, domain: String, effectuate: [String: Bool]) {
        self.name = name
        self.domain = domain
        self.effectuate = effectuate
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
}
