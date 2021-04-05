//
//  Name.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

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
