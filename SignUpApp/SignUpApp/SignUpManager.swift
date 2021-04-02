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
        static let didUpdateInterests = Notification.Name("didUpdateInterests")
    }
    
    //MARK:- 속성
    private var user: UserManageable
    private let textFieldMapper: TextFieldMappable
    private var interests: InterestsManageable
    private var isEnabledInSignUp = [false, false, false, false]
    private var isEnabledInInfo = [false, false, false]
    
    init(userManageable: UserManageable, textFieldMapper: TextFieldMappable) {
        self.user = userManageable
        self.textFieldMapper = textFieldMapper
        self.interests = Interests()
    }
    
    //MARK:- 행동
    func mapping(by index: Int) -> Validatable? {
        return textFieldMapper.mapping(by: index)
    }
    
    func isEnableNextSignUp(index: Int, isVaild: Bool) -> Bool {
        self.isEnabledInSignUp[index] = isVaild
        return isEnabledInSignUp[0] && isEnabledInSignUp[1] && isEnabledInSignUp[2] && isEnabledInSignUp[3]
    }
    
    func isEnableNextInformation(index: Int, isVaild: Bool) -> Bool {
        self.isEnabledInInfo[index] = isVaild
        return isEnabledInInfo[0] && isEnabledInInfo[1] && isEnabledInInfo[2]
    }
    
    func appendInterest(input interest: String) {
        self.interests.appendInterest(input: interest)
    }
    
    func readInterestCount() -> Int {
        return self.interests.count()
    }
    
    func readInterests() -> InterestsManageable {
        return self.interests.getInterests()
    }
}
