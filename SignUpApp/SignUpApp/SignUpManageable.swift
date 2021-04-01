//
//  SignUpManageable.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

protocol SignUpManageable {
    func mapping(by index: Int) -> Validatable?
    func isEnableNextSignUp(index: Int, isVaild: Bool) -> Bool
    func isEnableNextInformation(index: Int, isVaild: Bool) -> Bool
}
