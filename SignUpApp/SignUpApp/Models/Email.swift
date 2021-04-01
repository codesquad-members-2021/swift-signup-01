//
//  Email.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class Email: Validatable {
    enum Condition {
        static let valid = "올바른 형식입니다."
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
