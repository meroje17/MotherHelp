//
//  StudentSkillsTVCell.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class StudentSkillsTVCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backgroundWhiteView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private var validationLabels: [UILabel]!
    
    // MARK: - Initializer
    
    func configure(with student: Student, andGameName gameName: String) {
        backgroundWhiteView.layer.cornerRadius = 20
        backgroundWhiteView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundWhiteView.layer.shadowOpacity = 1
        backgroundWhiteView.layer.shadowOffset = .zero
        backgroundWhiteView.layer.shadowRadius = 10
        nameLabel.text = student.name
        var index = 0
        var array = [String]()
        for (key, _) in student.games[gameName]! {
            array.append(key)
        }
        let keys = sorted(array)
        for object in keys {
            if student.games[gameName]![object] == true {
                gameIsOver(validationLabels[index], withText: object)
            } else {
                gameNotOver(validationLabels[index], withText: object)
            }
            index += 1
        }
        if index != 26 {
            for number in index...25 {
                gameDoesntExist(validationLabels[number])
            }
        }
    }
    
    // MARK: - Private functions
    
    private func gameDoesntExist(_ label: UILabel) {
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.white
    }
    
    private func gameNotOver(_ label: UILabel, withText text: String) {
        label.backgroundColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        label.textColor = UIColor.black
        switch text {
        case "carré":
            label.text = "☐"
        case "étoile":
            label.text = "☆"
        case "losange":
            label.text = "◇"
        case "triangle":
            label.text = "△"
        case "rond":
            label.text = "◯"
        default:
            label.text = text
        }
    }
    
    private func gameIsOver(_ label: UILabel, withText text: String) {
        label.backgroundColor = UIColor(red: 120/255, green: 224/255, blue: 143/255, alpha: 1)
        label.textColor = UIColor.black
        switch text {
        case "carré":
            label.text = "☐"
        case "étoile":
            label.text = "☆"
        case "losange":
            label.text = "◇"
        case "triangle":
            label.text = "△"
        case "rond":
            label.text = "◯"
        default:
            label.text = text
        }
    }
    
    private func isNumber(_ test: String) -> Bool {
        guard let _ = Int(test) else { return false }
        return true
    }
    
    private func sorted(_ array: [String]) -> [String] {
        var numberArray = [Int]()
        var letterArray = [String]()
        if isNumber(array[0]) {
            for number in array {
                numberArray.append(Int(number)!)
            }
            let arraySorted = numberArray.sorted()
            var result = [String]()
            for number in arraySorted {
                result.append(String(number))
            }
            return result
        } else {
            letterArray = array.sorted()
            return letterArray
        }
    }
}
