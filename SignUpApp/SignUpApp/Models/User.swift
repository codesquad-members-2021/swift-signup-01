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
        let information = Information(name: Name(name: ""), email: Email(email: ""), birth: "", phoneNumber: PhoneNumber(phoneNumber: ""), interest: [])
        self.init(id: id, password: password, information: information)
    }
    
    func isValidId(input id: String) -> (Bool, String) {
        return self.id.isValid(input: id)
    }
    
    func isValidPassword(input pwd: String) -> (Bool, String) {
        return self.password.isValid(input: pwd)
    }
}


// MARK:- 세부 타입 선언

class ID: Validatable {
    enum Condition {
        static let valid = "사용 가능한 아이디입니다."
        static let invalid = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        static let duplictated = "이미 사용중인 아이디입니다"
    }
    
    private let id: String
    
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
    
}

class Password: Validatable {
    enum Condition {
        static let valid = "안전한 비밀번호입니다."
        static let invalidLength = "8자 이상 16자 이하로 입력해주세요."
        static let missingCapital = "영문 대문자를 최소 1자 이상 포함해주세요. "
        static let missingNumber = "숫자를 최소 1자 이상 포함해주세요."
        static let missingSpecial = "특수문자를 최소 1자 이상 포함해주세요."
    }
    
    private let password: String
    
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
    
    //MARK: valid check 내부 메소드
    
    private func checkLength(input: String) -> (Bool, String) {
        let lengthRegEx = "^.{8,16}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", lengthRegEx).evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.invalidLength
        
        return (isValid, condition)
    }
    
    private func checkCapital(input: String) -> (Bool, String) {
        let capitalRegEx = "^(?=.*[A-Z]).{1,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", capitalRegEx).evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingCapital
        
        return (isValid, condition)
    }
    
    private func checkNumber(input: String) -> (Bool, String) {
        let numberRegEx = "^(?=.*[0-9]).{1,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", numberRegEx).evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingNumber
        
        return (isValid, condition)
    }
    
    private func checkSpecial(input: String) -> (Bool, String) {
        let specialRegEx = "^(?=.*[!@#$%]).{1,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", specialRegEx).evaluate(with: input)
        let condition = isValid ? Condition.valid : Condition.missingSpecial
        
        return (isValid, condition)
        
    }
    
}
