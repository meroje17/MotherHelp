//
//  EditByRemovingController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class EditByRemovingController: UIViewController {

    // MARK: - Property
    
    var whatReceived: ComeFrom!
    private var coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "MotherHelp"))
    
    // MARK: - Outlets
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var removeButton: UIButton!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    // MARK: - Action
    
    @IBAction private func tapRemoveButton() {
        if nameTextField.text == "" && nameTextField.text != nil {
            sendAlert(withError: .nameFieldEmpty)
            return
        }
        switch whatReceived {
        case .student:
            if !isExist(inList: .student, withName: nameTextField.text!) {
                sendAlert(withError: .nameDoesntExist)
                return
            }
            removeInStaticList(of: .student, theObjectNamed: nameTextField.text!)
            coreDataManager.deleteStudent(named: nameTextField.text!)
        case .domain:
            if !isExist(inList: .domain, withName: nameTextField.text!) {
                sendAlert(withError: .nameDoesntExist)
                return
            }
            removeInStaticList(of: .domain, theObjectNamed: nameTextField.text!)
            coreDataManager.deleteDomain(named: nameTextField.text!)
        case .game:
            if !isExist(inList: .game, withName: nameTextField.text!) {
                sendAlert(withError: .nameDoesntExist)
                return
            }
            removeInStaticList(of: .game, theObjectNamed: nameTextField.text!)
            coreDataManager.deleteGame(named: nameTextField.text!)
        default:
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private functions
    
    private func initUI() {
        switch whatReceived {
        case .student:
            nameTextField.placeholder = "Nom de l'élève"
            descriptionLabel.text = "Entrez le nom de l'élève à supprimer de la base."
        case .domain:
            nameTextField.placeholder = "Nom du domaine"
            descriptionLabel.text = "Entrez le nom du domaine à supprimer de la base."
        case .game:
            nameTextField.placeholder = "Nom du jeu"
            descriptionLabel.text = "Entrez le nom du jeu à supprimer de la base."
        default:
            return
        }
        removeButton.layer.cornerRadius = 10
    }
    
    private func removeInStaticList(of type: ComeFrom, theObjectNamed name: String) {
        var index = 0
        switch type {
        case .student:
            for student in Student.list {
                if student.name == name {
                    Student.list.remove(at: index)
                    return
                }
                index += 1
            }
        case .domain:
            for domain in Domain.list {
                if domain.name == name {
                    Domain.list.remove(at: index)
                    return
                }
                index += 1
            }
        case .game:
            for game in Game.list {
                if game.name == name {
                    Game.list.remove(at: index)
                    return
                }
                index += 1
            }
        }
    }
    
    private func isExist(inList list: ComeFrom, withName name: String) -> Bool {
        switch list {
        case .student:
            for student in Student.list {
                if student.name == name { return true }
            }
            return false
        case .domain:
            for domain in Domain.list {
                if domain.name == name { return true }
            }
            return false
        case .game:
            for game in Game.list {
                if game.name == name { return true }
            }
            return false
        }
    }
}
