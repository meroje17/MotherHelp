//
//  EditStudentSkillsController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class EditStudentSkillsController: UIViewController {

    // MARK: - Properties
    
    var student: Student!
    var game: Game!
    private var indexForGame: Int!
    private var indexForStudent: Int!
    private var keys: [String]!
    private var sendFrom: AddOrRemove!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var validationCollectionView: UICollectionView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var removeButton: UIButton!
    
    // MARK: - Initializer
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        initBackground()
    }
    
    // MARK: - Action
    
    @IBAction func tapModifierButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sendFrom = .add
        case 1:
            sendFrom = .remove
        default:
            return
        }
        performSegue(withIdentifier: "tapAddOrRemoveButton", sender: nil)
    }
    
    
    // MARK: - Private functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tapAddOrRemoveButton", let nextController = segue.destination as? NameOfSkillsController {
            nextController.comeFrom = sendFrom
            nextController.indexOfGame = indexForGame
            nextController.indexOfStudent = indexForStudent
        }
    }
    
    private func initBackground() {
        indexForGame = whichIndexFor(game)
        indexForStudent = whichIndexFor(student)
        guard let dictionaryForCurrentGame = Student.list[indexForStudent].games[Game.list[indexForGame].name] else { return }
        keys = returnKeysOf(dictionaryForCurrentGame)
        validationCollectionView.dataSource = self
        validationCollectionView.delegate = self
        let nib = UINib(nibName: "ValidationGameCVCell", bundle: .main)
        validationCollectionView.register(nib, forCellWithReuseIdentifier: "validationGameCell")
        addButton.layer.cornerRadius = 10
        removeButton.layer.cornerRadius = 10
        validationCollectionView.reloadData()
    }
    
    private func whichIndexFor(_ student: Student) -> Int {
        var index = 0
        for studentInList in Student.list {
            if studentInList.name == student.name {
                return index
            }
            index += 1
        }
        return Int()
    }
    
    private func whichIndexFor(_ game: Game) -> Int {
        var index = 0
        for gameInList in Game.list {
            if gameInList.name == game.name {
                return index
            }
            index += 1
        }
        return Int()
    }
    
    private func returnKeysOf(_ dictionary: [String: Bool]) -> [String] {
        var result = [String]()
        for (key, _) in dictionary {
            result.append(key)
        }
        return result
    }
}

extension EditStudentSkillsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = Student.list[indexForStudent].games[Game.list[indexForGame].name] else { return Int() }
        return game.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "validationGameCell", for: indexPath) as? ValidationGameCVCell else { return UICollectionViewCell() }
        cell.configure(withName: Student.list[indexForStudent], and: Game.list[indexForGame], and: indexPath.row)
        return cell
    }
}

extension EditStudentSkillsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
