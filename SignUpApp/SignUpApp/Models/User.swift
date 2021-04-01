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
    
    init(id: ID, password: Password, information: Information) {
        self.id = id
        self.password = password
        self.passwordConfirm = PasswordConfirm(password: "")
        self.information = information
    }
    
    convenience init() {
        let id = ID()
        let password = Password()
        let information = Information(name: Name(), email: Email(), birth: "", phoneNumber: PhoneNumber(phoneNumber: ""), interest: [])
        
        self.init(id: id, password: password, information: information)
    }
    
    func isValidId(input id: String) -> (Bool, String) {
        return self.id.isValid(input: id)
    }
    
    func isValidPassword(input pwd: String) -> (Bool, String) {
        return self.password.isValid(input: pwd)
    }
}
