//
//  SignUpManager.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class SignUpManager: SignUpManageable {
    enum NotificationName {
        static let didUpdateTextField = Notification.Name("didUpdateTextField")
    }
    
    //MARK:- 속성
    private var user: UserManageable
    private let textFieldMapper: TextFieldMappable
    private var isEnabledArray = [false, false, false, false]
    
    init(userManageable: UserManageable, textFieldMapper: TextFieldMappable) {
        self.user = userManageable
        self.textFieldMapper = textFieldMapper
    }
    
    //MARK:- 행동
    func mapping(by index: Int) -> Validatable? {
        return textFieldMapper.mapping(by: index)
    }
    
    func isEnableNext(index: Int, isVaild: Bool) -> Bool {
        self.isEnabledArray[index] = isVaild
        return isEnabledArray[0] && isEnabledArray[1] && isEnabledArray[2] && isEnabledArray[3]
    }
}
