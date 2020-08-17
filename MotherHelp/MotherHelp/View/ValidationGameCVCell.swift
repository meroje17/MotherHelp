//
//  ValidationGameCVCell.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class ValidationGameCVCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var nameOfValidation: UILabel!
    @IBOutlet private weak var validationImage: UIImageView!
    @IBOutlet private weak var backgroundRoundView: UIView!
    
    // MARK: - Initializer
    
    func configure(withName student: Student, and game: Game, and row: Int) {
        backgroundRoundView.layer.cornerRadius = 5
        var keys = [String]()
        for (key, _) in game.effectuate {
            keys.append(key)
        }
        let keysSorted = sorted(keys)
        switch keysSorted[row] {
        case "carré":
            nameOfValidation.text = "☐"
        case "étoile":
            nameOfValidation.text = "☆"
        case "losange":
            nameOfValidation.text = "◇"
        case "triangle":
            nameOfValidation.text = "△"
        case "rond":
            nameOfValidation.text = "◯"
        default:
            nameOfValidation.text = keysSorted[row]
        }
        switch student.games[game.name]![keysSorted[row]] {
        case true:
            validationImage.image = UIImage(systemName: "checkmark.circle.fill")
            validationImage.tintColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
        case false:
            validationImage.image = UIImage(systemName: "clear.fill")
            validationImage.tintColor = UIColor(red: 148/255, green: 17/255, blue: 0/255, alpha: 1)
        default:
            return
        }
    }
    
    // MARK: - Private functions
    
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
