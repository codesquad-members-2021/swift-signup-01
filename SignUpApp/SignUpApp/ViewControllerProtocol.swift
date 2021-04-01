//
//  ViewControllerProtocol.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit

protocol EditViewControllerDelegate: class {
    func mapping(by index: Int) -> Validatable?
    func getIndex(textField: UITextField) -> Int?
    func setConditionLabelText(index: Int, condition: String)
    func setConditionLabelColor(index: Int, color: UIColor)
    func getTextField(index: Int) -> UITextField?
    func getTextFieldText(index: Int) -> String
}
