//
//  SignUpManager.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class SignUpManager {
    
    //MARK:- 속성
    private var user: UserManageable
    
    init(userManageable: UserManageable) {
        self.user = userManageable
    }
    
    //MARK:- 행동
    func isValidateId(id: String) -> Bool {
        return user.isValidId(id: id)
    }
    
    func isValidatePassword(pwd: String) -> Bool {
        return user.isValidPassword(pwd: pwd)
    }
    
    func isValidateEmail(email: String) -> Bool {
        return user.isValidEmail(email: email)
    }
    
    func isValidatePhoneNumber(phoneNumber: String) -> Bool {
        return user.isValidPhoneNumber(phoneNumber: phoneNumber)
    }
}
