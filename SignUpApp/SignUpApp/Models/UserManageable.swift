//
//  UserManageable.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

protocol UserManageable {
    func isValidId(id: String) -> Bool
    func isValidPassword(pwd: String) -> Bool
    func isValidEmail(email: String) -> Bool
    func isValidPhoneNumber(phoneNumber: String) -> Bool
}
