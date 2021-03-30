//
//  ValidationFactory.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/30.
//

import Foundation

protocol TextFieldValidatable {
    static func isValid(valid type: Validatable, textFieldText: String) -> Bool
}

class ValidationFactory: TextFieldValidatable {
    static func isValid(valid type: Validatable, textFieldText: String) -> Bool {
        return type.isValid(input: textFieldText)
    }
}
