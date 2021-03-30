//
//  TextFieldMapper.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/30.
//

import Foundation

class TextFieldMapper: TextFieldMappable {
    private let map: [Int: Validatable]
    private let userInfos: [Validatable]
    
    init(userInfos: [Validatable]) {
        var map: [Int: Validatable] = [:]
        self.userInfos = userInfos
        let indexs = 0...userInfos.count
        
        for (index, userInfo) in zip(indexs, userInfos) {
            map[index] = userInfo
        }
        
        self.map = map
    }
    
    func mapping(by index: Int) -> Validatable? {
        return map[index]
    }
}

protocol TextFieldMappable {
    func mapping(by index: Int) -> Validatable?
}
