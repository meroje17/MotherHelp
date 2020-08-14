//
//  EditController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

// Enum for next controller knows what deals

enum ComeFrom {
    case student, domain, game
}

final class EditController: UIViewController {

    // MARK: - Properties
    
    private var coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "MotherHelp"))
    private var whatSend: ComeFrom!
    
    // MARK: - Actions
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            whatSend = .student
        case 1:
            whatSend = .domain
        case 2:
            whatSend = .game
        default:
            return
        }
        performSegue(withIdentifier: "tapAddButton", sender: nil)
    }
    
    @IBAction func tapRemoveButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            whatSend = .student
        case 1:
            whatSend = .domain
        case 2:
            whatSend = .game
        default:
            return
        }
        performSegue(withIdentifier: "tapRemoveButton", sender: nil)
    }
    
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tapAddButton", let nextController = segue.destination as? EditByAddingController {
            nextController.whatReceived = whatSend
        }
        if segue.identifier == "tapRemoveButton", let nextController = segue.destination as? EditByRemovingController {
            nextController.whatReceived = whatSend
        }
    }
    
    private func initBackground() {
        for student in coreDataManager.students {
            Student.list.append(Student(withCoreData: student))
        }
        for domain in coreDataManager.domains {
            Domain.list.append(Domain(withCoreData: domain))
        }
        for game in coreDataManager.games {
            Game.list.append(Game(withCoreData: game))
        }
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackground()
        for student in Student.list {
            print(student.name)
            print(student.games)
        }
        for game in Game.list {
            print(game.name)
        }
        for domain in Domain.list {
            print(domain.name)
        }
    }
}
