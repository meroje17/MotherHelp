//
//  ExtensionController+SendAlert.swift
//  MotherHelp
//
//  Created by Jérôme Guèrin on 12/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

enum AlertError: String {
    case nameFieldEmpty = "Le champ du nom doit être rempli pour pouvoir fonctionner."
    case nameDoesntExist = "Le nom saisit n'existe pas, veuillez changer."
}

extension UIViewController {
    func sendAlert(withError error: AlertError) {
        let controller = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(controller, animated: true)
    }
}
