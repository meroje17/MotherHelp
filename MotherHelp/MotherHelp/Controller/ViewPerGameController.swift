//
//  ViewPerGameController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class ViewPerGameController: UIViewController {

    // MARK: - Properties
    
    private var gameName: String!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var gamePickerView: UIPickerView!
    @IBOutlet private weak var studentsSkillTableView: UITableView!
    
    // MARK: - Private functions
    
    private func initBackground() {
        gameName = Game.list[0].name
        gamePickerView.dataSource = self
        gamePickerView.delegate = self
        studentsSkillTableView.dataSource = self
        let nib = UINib(nibName: "StudentSkillsTVCell", bundle: .main)
        studentsSkillTableView.register(nib, forCellReuseIdentifier: "StudentSkillsCell")
        gamePickerView.reloadAllComponents()
        studentsSkillTableView.reloadData()
    }
    
    // MARK: - Initializer
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        initBackground()
    }
}

extension ViewPerGameController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Student.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentSkillsCell", for: indexPath) as? StudentSkillsTVCell else { return UITableViewCell() }
        cell.configure(with: Student.list[indexPath.row], andGameName: gameName)
        return cell
    }
}

extension ViewPerGameController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Game.list.count
    }
}

extension ViewPerGameController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Game.list[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameName = Game.list[row].name
        studentsSkillTableView.reloadData()
    }
}
