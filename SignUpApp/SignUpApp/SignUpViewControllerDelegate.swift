//
//  SignUpViewControllerDelegate.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    private weak var signUpViewController: SignUpViewController?
    
    init(_ signUpViewController: SignUpViewController) {
        self.signUpViewController = signUpViewController
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let index = self.signUpViewController?.signUpTextFields.firstIndex(of: textField) else { return }
        guard let validatable = self.signUpViewController?.mapping(by: index) else { return }
        
        ValidationFactory.saveProperty(valid: validatable, textFieldText: textField.text ?? "")
        
        let text = index == 2 ? self.signUpViewController?.signUpTextFields[1].text ?? "" : textField.text ?? ""
        let tuple = ValidationFactory.isValid(valid: validatable, textFieldText: text)
        let isValid = tuple.0
        let condition = tuple.1
        
        self.updateTextField(isValid: isValid, condition: condition, labelIndex: index, textField: textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //class에 값을 넣고 다음 텍스트 필드로
        guard let index = self.signUpViewController?.signUpTextFields.firstIndex(of: textField) else { return false }
        
        if let nextResponder = self.signUpViewController?.signUpTextFields[index + 1] {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    private func updateTextField(isValid: Bool, condition: String, labelIndex index: Int, textField: UITextField) {
        textField.layer.borderWidth = 1
        
        if isValid {
            self.updateColor(UIColor.systemGreen, textField: textField, labelIndex: index)
            NotificationCenter.default.post(name: SignUpManager.NotificationName.didUpdateTextField, object: index)
        } else {
            self.updateColor(UIColor.systemRed, textField: textField, labelIndex: index)
        }
        
        self.signUpViewController?.conditionLabels[index].text = condition
    }
    
    private func updateColor(_ color: UIColor, textField: UITextField, labelIndex index: Int) {
        textField.layer.borderColor = color.cgColor
        self.signUpViewController?.conditionLabels[index].textColor = color
    }
}
