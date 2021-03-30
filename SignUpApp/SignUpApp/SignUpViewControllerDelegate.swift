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
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.black.cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
