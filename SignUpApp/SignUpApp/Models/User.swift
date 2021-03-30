//
//  User.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class User: UserManageable {
    private let id: ID
    private let password: Password
    private let information: Information
    
    init(id: ID, password: Password, information: Information) {
        self.id = id
        self.password = password
        self.information = information
    }
    
    convenience init() {
        let id = ID(id: "")
        let password = Password(password: "")
        let information = Information(name: "", email: Email(email: ""), birth: "", phoneNumber: PhoneNumber(phoneNumber: ""), interest: [])
        self.init(id: id, password: password, information: information)
    }
    
    func isValidId(input id: String) -> Bool {
        return self.id.isValid(input: id)
    }
    
    func isValidPassword(input pwd: String) -> Bool {
        return self.password.isValid(input: pwd)
    }
}

class ID: Validatable {
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    
    convenience init() {
        let id = ""
        self.init(id: id)
    }
    
    func isValid(input: String) -> Bool {
        let idRegEx = "^[a-z0-9_-]{5,20}$"
        let idValidation = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idValidation.evaluate(with: input)
    }
}

class Password: Validatable {
    private let password: String
    
    init(password: String) {
        self.password = password
    }
    
    convenience init() {
        let password = ""
        self.init(password: password)
    }
    
    func isValid(input: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9!@#$%]{8,16}$"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordValidation.evaluate(with: input)
    }
}
