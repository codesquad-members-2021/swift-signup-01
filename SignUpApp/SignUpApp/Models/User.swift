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
    private let information: Information
    
    init(id: ID, password: Password, information: Information, passwordConfirm: PasswordConfirm) {
        self.id = id
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.information = information
    }
    
    convenience init() {
        let id = ID()
        let password = Password()
        let passwordConfirm = PasswordConfirm()
        let information = Information(name: Name(), email: Email(), birth: Birth(), phoneNumber: PhoneNumber(), interest: [])
        
        self.init(id: id, password: password, information: information, passwordConfirm: passwordConfirm)
    }
    
    func isValidId(input id: String) -> (Bool, String) {
        return self.id.isValid(input: id)
    }
    
    func isValidPassword(input pwd: String) -> (Bool, String) {
        return self.password.isValid(input: pwd)
    }
}
