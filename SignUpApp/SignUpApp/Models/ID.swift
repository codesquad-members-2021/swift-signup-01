//
//  ID.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class ID: Validatable, Decodable {
    enum Condition {
        static let valid = "사용 가능한 아이디입니다."
        static let invalid = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        static let duplictated = "이미 사용중인 아이디입니다"
    }
    
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    convenience init() {
        let id = ""
        self.init(id: id)
    }
    
    func isValid(input: String) -> (Bool, String) {
        let idRegEx = "^[a-z0-9_-]{5,20}$"
        let idValidation = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        let isValid = idValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalid
        
        return (isValid, condition)
    }
    
    func saveProperty(input: String) {
        self.id = input
    }
}
