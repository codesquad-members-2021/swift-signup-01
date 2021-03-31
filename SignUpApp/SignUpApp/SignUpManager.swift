//
//  SignUpManager.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class SignUpManager: SignUpManageable {
    
    //MARK:- 속성
    private var user: UserManageable
    private let textFieldMapper: TextFieldMappable
    
    init(userManageable: UserManageable, textFieldMapper: TextFieldMappable) {
        self.user = userManageable
        self.textFieldMapper = textFieldMapper
    }
    
    //MARK:- 행동
    func mapping(by index: Int) -> Validatable? {
        return textFieldMapper.mapping(by: index)
    }
}
