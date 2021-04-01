//
//  SignUpViewControllerDelegate.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    private var editViewController: EditViewControllerDelegate
    
    init(_ editViewController: EditViewControllerDelegate) {
        self.editViewController = editViewController
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let index = self.editViewController.getIndex(textField: textField) else { return }
        guard let validatable = self.editViewController.mapping(by: index) else { return }
        
        ValidationFactory.saveProperty(valid: validatable, textFieldText: textField.text ?? "")
        let text = self.editViewController.getTextFieldText(index: index)
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
        guard let index = self.editViewController.getIndex(textField: textField) else { return false }
        
        if let nextResponder = self.editViewController.getTextField(index: index + 1) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    private func updateTextField(isValid: Bool, condition: String, labelIndex index: Int, textField: UITextField) {
        var info = [String: Any]()
        info["index"] = index
        info["isValid"] = isValid
        
        textField.layer.borderWidth = 1
        
        if isValid {
            self.updateColor(UIColor.systemGreen, textField: textField, labelIndex: index)
        } else {
            self.updateColor(UIColor.systemRed, textField: textField, labelIndex: index)
        }
        
        self.editViewController.setConditionLabelText(index: index, condition: condition)
        NotificationCenter.default.post(name: SignUpManager.NotificationName.didUpdateTextField, object: self, userInfo: info)
    }
    
    private func updateColor(_ color: UIColor, textField: UITextField, labelIndex index: Int) {
        textField.layer.borderColor = color.cgColor
        self.editViewController.setConditionLabelColor(index: index, color: color)
    }
}
