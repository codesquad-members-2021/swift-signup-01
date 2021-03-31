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
        let isValid = ValidationFactory.isValid(valid: validatable, textFieldText: textField.text ?? "")
        self.updateTextFieldBorder(isValid: isValid, condition: "알맞은 형식입니다", labelIndex: index, textField: textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
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
    
    private func updateTextFieldBorder(isValid: Bool, condition: String, labelIndex index: Int, textField: UITextField) {
        textField.layer.borderWidth = 1
        if isValid {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
            self.signUpViewController?.conditionLabels[index].textColor = .systemGreen
        } else {
            textField.layer.borderColor = UIColor.systemRed.cgColor
            self.signUpViewController?.conditionLabels[index].textColor = .systemRed
        }
        
        updateCondition(condition: condition, labelIndex: index)
    }
    
    private func updateCondition(condition: String, labelIndex index: Int) {
        self.signUpViewController?.conditionLabels[index].text = condition
    }
}
