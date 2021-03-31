//
//  Information.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class Information {
    private let name: Name
    private let email: Email
    private let birth: String
    private let phoneNumber: PhoneNumber
    private let interest: [String]
    
    init(name: Name, email: Email, birth: String, phoneNumber: PhoneNumber, interest: [String]) {
        self.name = name
        self.email = email
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.interest = interest
    }
}

class Email: Validatable {
    enum Condition {
        static let valid = ""
        static let invalid = "이메일 주소를 다시 확인해주세요."
    }
    
    private var email: String
    
    init(email: String) {
        self.email = email
    }
    
    convenience init() {
        let email = ""
        self.init(email: email)
    }
    
    func isValid(input: String) -> (Bool, String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    func saveProperty(input: String) {
        self.email = input
    }
}

class PhoneNumber: Validatable {
    enum Condition {
        static let valid = ""
        static let invalid = "형식에 맞지 않는 번호입니다."
    }
    
    private var phoneNumber: String
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    convenience init() {
        let phoneNumber = ""
        self.init(phoneNumber: phoneNumber)
    }
    
    func isValid(input: String) -> (Bool, String) {
        let phoneNumberRegex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let phoneNumberValidation = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValid = phoneNumberValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    func saveProperty(input: String) {
        self.phoneNumber = input
    }
}

class Name: Validatable {
    enum Condition {
        static let valid = ""
        static let invalid = "이름은 필수 입력 항목입니다."
    }
    
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    convenience init() {
        let name = ""
        self.init(name: name)
    }
    
    func isValid(input: String) -> (Bool, String) {
        let isValid = input.count > 0
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    func saveProperty(input: String) {
        self.name = input
    }
}


