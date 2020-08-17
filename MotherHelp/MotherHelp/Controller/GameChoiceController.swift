//
//  GameChoiceController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class GameChoiceController: UIViewController {

    // MARK: - Properties
    
    var student: Student!
    var domain: Domain!
    private var game: Game!
    private var games = [Game]()

    // MARK: - Outlets
    
    @IBOutlet private weak var gamesTableView: UITableView!
    @IBOutlet private weak var studentNameLabel: UILabel!
    
    // MARK: - Initializer
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initBackground()
    }
    
    // MARK: - Private functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameChoosed", let nextController = segue.destination as? EditStudentSkillsController {
            nextController.game = game
            nextController.student = student
        }
    }
    
    private func initBackground() {
        games = [Game]()
        studentNameLabel.text = student.name
        for game in Game.list {
            if game.domain == domain.name {
                games.append(game)
            }
        }
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
        let nib = UINib(nibName: "DomainAndGameTVCell", bundle: .main)
        gamesTableView.register(nib, forCellReuseIdentifier: "DomainOrGameCell")
        gamesTableView.reloadData()
    }
}

extension GameChoiceController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DomainOrGameCell", for: indexPath) as? DomainAndGameTVCell else { return UITableViewCell() }
        cell.configure(with: games[indexPath.row])
        return cell
    }
}

extension GameChoiceController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        game = games[indexPath.row]
        performSegue(withIdentifier: "gameChoosed", sender: nil)
    }
}
