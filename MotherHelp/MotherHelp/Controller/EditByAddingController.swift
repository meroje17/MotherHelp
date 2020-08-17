//
//  EditByAddingController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class EditByAddingController: UIViewController {

    // MARK: - Property
    
    var whatReceived: ComeFrom!
    private var typeOfGameSelected = TypeOfGame.numeric
    private var domainSelected: String?
    private let coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "MotherHelp"))
    private let typeOfGame = [TypeOfGame.numeric, TypeOfGame.alpha, TypeOfGame.sound, TypeOfGame.form]
    
    // MARK: - Outlets
    
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var domainView: UIView!
    @IBOutlet private weak var typeView: UIView!
    @IBOutlet private weak var domainPickerView: UIPickerView!
    @IBOutlet private weak var typePickerView: UIPickerView!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initBackground()
    }
    
    // MARK: - Actions
    
    @objc private func hideKeyboard() {
        nameTextField.resignFirstResponder()
    }
    
    @IBAction private func tapAddButton() {
        if nameTextField.text == "" && nameTextField.text != nil {
            sendAlert(withError: .nameFieldEmpty)
            return
        }
        switch whatReceived {
        case .student:
            let student = createStudent(with: nameTextField.text!)
            Student.list.append(student)
            coreDataManager.create(student: student)
        case .domain:
            let domain = Domain(name: nameTextField.text!)
            Domain.list.append(domain)
            coreDataManager.create(domain: domain)
        case .game:
            guard let domain = domainSelected else { sendAlert(withError: .domainEmpty); return }
            let game = Game(name: nameTextField.text!, domain: domain, typeOfGame: typeOfGameSelected)
            Game.list.append(game)
            for student in Student.list {
                student.addingGame(named: game)
                coreDataManager.update(student: student)
            }
            coreDataManager.create(game: game)
        default:
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private functions
    
    private func createStudent(with name: String) -> Student {
        var games = [String: [String: Bool]]()
        for game in Game.list {
            games.updateValue(game.effectuate, forKey: game.name)
        }
        let student = Student(name: name, games: games)
        return student
    }
    
    private func initBackground() {
        if Domain.list.count == 0 {
            domainPickerView.isUserInteractionEnabled = false
        } else {
            domainPickerView.isUserInteractionEnabled = true
            domainSelected = Domain.list[0].name
        }
        nameTextField.delegate = self
        domainPickerView.delegate = self
        typePickerView.delegate = self
        domainPickerView.dataSource = self
        typePickerView.dataSource = self
        typePickerView.setValue(UIColor.white, forKeyPath: "textColor")
        domainPickerView.setValue(UIColor.white, forKeyPath: "textColor")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func initUI() {
        switch whatReceived {
        case .student:
            nameTextField.placeholder = "Nom de l'élève"
            hideDomainAndTypeOfGame()
        case .domain:
            nameTextField.placeholder = "Nom du domaine"
            hideDomainAndTypeOfGame()
        case .game:
            nameTextField.placeholder = "Nom du jeu"
        default:
            return
        }
        addButton.layer.cornerRadius = 10
    }
    
    private func hideDomainAndTypeOfGame() {
        domainView.isHidden = true
        typeView.isHidden = true
    }
}

extension EditByAddingController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}

extension EditByAddingController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return Domain.list.count
        } else {
            return typeOfGame.count
        }
    }
}

extension EditByAddingController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return Domain.list[row].name
        } else {
            return typeOfGame[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            domainSelected = Domain.list[row].name
        } else {
            typeOfGameSelected = typeOfGame[row]
        }
    }
}
