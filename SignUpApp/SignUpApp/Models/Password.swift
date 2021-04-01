//
//  Password.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class Password: Validatable {
    enum Condition {
        static let valid = "안전한 비밀번호입니다."
        static let invalidLength = "8자 이상 16자 이하로 입력해주세요."
        static let missingCapital = "영문 대문자를 최소 1자 이상 포함해주세요. "
        static let missingNumber = "숫자를 최소 1자 이상 포함해주세요."
        static let missingSpecial = "특수문자를 최소 1자 이상 포함해주세요."
    }
    
    private var password: String
    
    init(password: String) {
        self.password = password
    }
    
    convenience init() {
        let password = ""
        self.init(password: password)
    }
    
    //MARK: -METHOD
    
    func isValid(input: String) -> (Bool, String) {
        if !checkLength(input: input).0 { return checkLength(input: input) }
        if !checkCapital(input: input).0 { return checkCapital(input: input) }
        if !checkNumber(input: input).0 { return checkNumber(input: input) }
        if !checkSpecial(input: input).0 { return checkSpecial(input: input) }
        
        return (true, Condition.valid)
    }
    
    func saveProperty(input: String) {
        self.password = input
    }
    
    //MARK: valid check 내부 메소드
    
    private func checkLength(input: String) -> (Bool, String) {
        let lengthRegEx = "^.{8,16}$"
        let lengthValidation = NSPredicate(format: "SELF MATCHES %@", lengthRegEx)
        let isValid = lengthValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalidLength
        
        return (isValid, condition)
    }
    
    private func checkCapital(input: String) -> (Bool, String) {
        let capitalRegEx = "^(?=.*[A-Z]).{1,}$"
        let capitalValidation = NSPredicate(format: "SELF MATCHES %@", capitalRegEx)
        let isValid = capitalValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingCapital
        
        return (isValid, condition)
    }
    
    private func checkNumber(input: String) -> (Bool, String) {
        let numberRegEx = "^(?=.*[0-9]).{1,}$"
        let numberValidation = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let isValid = numberValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingNumber
        
        return (isValid, condition)
    }
    
    private func checkSpecial(input: String) -> (Bool, String) {
        let specialRegEx = "^(?=.*[!@#$%]).{1,}$"
        let specialValidation = NSPredicate(format: "SELF MATCHES %@", specialRegEx)
        let isValid = specialValidation.evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingSpecial
        
        return (isValid, condition)
    }
}
