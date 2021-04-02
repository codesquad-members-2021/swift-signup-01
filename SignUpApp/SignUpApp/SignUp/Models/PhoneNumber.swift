//
//  PhoneNumber.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class PhoneNumber: Validatable {
    enum Condition {
        static let valid = "올바른 형식입니다"
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
        let phoneNumberRegex = "^010-(?=.*[0-9]).{3,4}-(?=.*[0-9]).{4}$"
        let phoneNumberValidation = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValid = phoneNumberValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    func saveProperty(input: String) {
        self.phoneNumber = input
    }
}
