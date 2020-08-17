//
//  DomainAndGameTVCell.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class DomainAndGameTVCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var backgroundWhiteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Initializer
    
    func configure(with domain: Domain) {
        backgroundWhiteView.layer.cornerRadius = 20
        backgroundWhiteView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundWhiteView.layer.shadowOpacity = 1
        backgroundWhiteView.layer.shadowOffset = .zero
        backgroundWhiteView.layer.shadowRadius = 5
        nameLabel.text = domain.name
    }
    
    func configure(with game: Game) {
        backgroundWhiteView.layer.cornerRadius = 20
        backgroundWhiteView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundWhiteView.layer.shadowOpacity = 1
        backgroundWhiteView.layer.shadowOffset = .zero
        backgroundWhiteView.layer.shadowRadius = 5
        nameLabel.text = game.name
    }
}
