//
//  SignUpManageable.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

protocol SignUpManageable {
    func isValidateId(id: String) -> Bool
    func isValidatePassword(pwd: String) -> Bool
}
