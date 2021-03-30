//
//  UserManageable.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

protocol UserManageable {
    func isValidId(input id: String) -> Bool
    func isValidPassword(input pwd: String) -> Bool
}

protocol Validatable {
    func isValid(input: String) -> Bool
}
