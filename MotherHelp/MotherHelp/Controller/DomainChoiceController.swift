//
//  DomainChoiceController.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 10/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class DomainChoiceController: UIViewController {

    // MARK: - Properties
    
    private var student: Student!
    private var domain: Domain!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var studentsPickerView: UIPickerView!
    @IBOutlet private weak var domainTableView: UITableView!
    
    // MARK: - Initializer
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initBackground()
    }
    
    // MARK: - Private functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "domainChoosed", let nextController = segue.destination as? GameChoiceController {
            nextController.student = student
            nextController.domain = domain
        }
    }
    
    private func initBackground() {
        studentsPickerView.delegate = self
        studentsPickerView.dataSource = self
        if Student.list.count == 0 {
            studentsPickerView.isUserInteractionEnabled = false
        } else {
            studentsPickerView.isUserInteractionEnabled = true
            student = Student.list[0]
        }
        domainTableView.dataSource = self
        domainTableView.delegate = self
        let nib = UINib(nibName: "DomainAndGameTVCell", bundle: .main)
        domainTableView.register(nib, forCellReuseIdentifier: "DomainOrGameCell")
        studentsPickerView.reloadAllComponents()
        domainTableView.reloadData()
    }
}

extension DomainChoiceController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Student.list.count
    }
}

extension DomainChoiceController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Student.list[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        student = Student.list[row]
    }
}

extension DomainChoiceController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Domain.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DomainOrGameCell", for: indexPath) as? DomainAndGameTVCell else { return UITableViewCell() }
        cell.configure(with: Domain.list[indexPath.row])
        return cell
    }
}

extension DomainChoiceController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        domain = Domain.list[indexPath.row]
        performSegue(withIdentifier: "domainChoosed", sender: nil)
    }
}
