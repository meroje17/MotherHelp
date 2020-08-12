//
//  Domain.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

final class Domain {
    
    // MARK: - Properties
    
    static var list = [Domain]()
    var name: String
    
    // MARK: - Initializer
    
    init(name: String) {
        self.name = name
    }
    
    init(withCoreData domain: DomainEntity) {
        self.name = domain.name!
    }
}
