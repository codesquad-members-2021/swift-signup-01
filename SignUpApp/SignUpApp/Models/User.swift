//
//  User.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

struct User: UserManageable {
    private let id: String
    private let password: String
    private let information: Information
    
    func isValidId(id: String) -> Bool {
        let idRegEx = "^[a-z0-9_-]{5,20}$"
        let idValidation = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idValidation.evaluate(with: id)
    }
    
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9!@#$%]{8,16}$"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordValidation.evaluate(with: pwd)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailValidation.evaluate(with: email)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let phoneNumberValidation = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberValidation.evaluate(with: phoneNumber)
    }
}
