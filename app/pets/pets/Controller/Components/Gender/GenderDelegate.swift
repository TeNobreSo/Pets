//
//  GenderDelegate.swift
//  pets
//
//  Created by Matheus Silva on 01/03/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class GenderDelegate: NSObject, UIPickerViewDelegate {
    var options  = ["Macho", "Femêa"]
    weak var viewController: UIViewController?
    func config(pickerPerson: UIPickerView, viewController: UIViewController) {
        pickerPerson.delegate = self
        self.viewController = viewController
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let view = viewController as? PetCreateViewController {
            view.genderSelected = options[row]
        }
    }
}
