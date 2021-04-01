//
//  PasswordConfirm.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class PasswordConfirm: Validatable {
    enum Condition {
        static let valid = "비밀번호가 일치합니다."
        static let invalid = "비밀번호가 일치하지 않습니다."
    }
    
    private var password: String
    
    init(password: String) {
        self.password = password
    }
    
    convenience init() {
        let password = ""
        self.init(password: password)
    }
    
    func isValid(input: String) -> (Bool, String) {
        let isValid = password == input
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    // 비밀번호를 저장한다 (재확인 비번 X)
    func saveProperty(input: String) {
        self.password = input
    }
}
