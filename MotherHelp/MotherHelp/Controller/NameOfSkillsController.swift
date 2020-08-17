//
//  NameOfSkillsController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

enum AddOrRemove {
    case add, remove
}

final class NameOfSkillsController: UIViewController {

    // MARK: - Properties
    
    var indexOfGame: Int!
    var indexOfStudent: Int!
    var comeFrom: AddOrRemove!
    private var coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "MotherHelp"))
    
    // MARK: - Outlets
    
    @IBOutlet private weak var addOrRemoveLabel: UILabel!
    @IBOutlet private weak var addOrRemoveButton: UIButton!
    @IBOutlet private weak var keyTextField: UITextField!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackground()
    }
    
    // MARK: - Action
    
    @IBAction func tapAddOrRemoveButton() {
        guard let key = keyTextField.text, key != "" else {
            sendAlert(withError: .nameFieldEmpty)
            return
        }
        if Student.list[indexOfStudent].games[Game.list[indexOfGame].name]?[key] == nil {
            sendAlert(withError: .nameDoesntExist)
            return
        }
        switch comeFrom {
        case .add:
            Student.list[indexOfStudent].games[Game.list[indexOfGame].name]![key] = true
            coreDataManager.update(student: Student.list[indexOfStudent])
        case .remove:
            Student.list[indexOfStudent].games[Game.list[indexOfGame].name]![key] = false
            coreDataManager.update(student: Student.list[indexOfStudent])
        default:
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private function
    
    private func initBackground() {
        switch comeFrom {
        case .add:
            addOrRemoveLabel.text = "Entrez le nom de l'exercice effectué."
            addOrRemoveButton.backgroundColor = UIColor(red: 120/255, green: 224/255, blue: 143/255, alpha: 1)
            addOrRemoveButton.setTitle("Ajouter", for: .normal)
        case .remove:
            addOrRemoveLabel.text = "Entrez le nom de l'exercice non-effectué."
            addOrRemoveButton.tintColor = UIColor(red: 148/255, green: 17/255, blue: 0/255, alpha: 1)
            addOrRemoveButton.setTitle("Supprimer", for: .normal)
        default:
            return
        }
        addOrRemoveButton.layer.cornerRadius = 10
    }
}
