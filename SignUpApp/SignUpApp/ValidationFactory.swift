//
//  ValidationFactory.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/30.
//

import Foundation

protocol TextFieldValidatable {
    static func isValid(valid type: Validatable, textFieldText: String) -> (Bool, String)
}

class ValidationFactory: TextFieldValidatable {
    static func isValid(valid type: Validatable, textFieldText: String) -> (Bool, String) {
        return type.isValid(input: textFieldText)
    }
}
