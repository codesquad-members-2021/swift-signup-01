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
    private let passwordConfirm: PasswordConfirm
    private let name: Name
    private let email: Email
    private let birth: Birth
    private let phoneNumber: PhoneNumber
    private let interests: Interests
    
    init(id: ID, password: Password, passwordConfirm: PasswordConfirm, name: Name, email: Email, birth: Birth, phoneNumber: PhoneNumber, interests: Interests) {
        self.id = id
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.name = name
        self.email = email
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.interests = interests
    }
    
    convenience init() {
        let id = ID()
        let password = Password()
        let passwordConfirm = PasswordConfirm()
        let interests = Interests()
        let name = Name()
        let email = Email()
        let birth = Birth()
        let phoneNumber = PhoneNumber()
        
        self.init(id: id, password: password, passwordConfirm: passwordConfirm, name: name, email: email, birth: birth, phoneNumber: phoneNumber, interests: interests)
    }
    
    func isValidId(input id: String) -> (Bool, String) {
        return self.id.isValid(input: id)
    }
    
    func isValidPassword(input pwd: String) -> (Bool, String) {
        return self.password.isValid(input: pwd)
    }
}
