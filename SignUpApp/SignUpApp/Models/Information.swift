//
//  Information.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class Information {
    private let name: String
    private let email: Email
    private let birth: String
    private let phoneNumber: PhoneNumber
    private let interest: [String]
    
    init(name: String, email: Email, birth: String, phoneNumber: PhoneNumber, interest: [String]) {
        self.name = name
        self.email = email
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.interest = interest
    }
}

class Email: Validatable {
    private let email: String
    
    init(email: String) {
        self.email = email
    }
    
    convenience init() {
        let email = ""
        self.init(email: email)
    }
    
    func isValid(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailValidation.evaluate(with: input)
    }
}

class PhoneNumber: Validatable {
    private let phoneNumber: String
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    convenience init() {
        let phoneNumber = ""
        self.init(phoneNumber: phoneNumber)
    }
    
    func isValid(input: String) -> Bool {
        let phoneNumberRegex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let phoneNumberValidation = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberValidation.evaluate(with: input)
    }
}
