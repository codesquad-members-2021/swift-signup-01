//
//  Information.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import Foundation

class Information {
    private let name: Name
    private let email: Email
    private let birth: String
    private let phoneNumber: PhoneNumber
    private let interest: [String]
    
    init(name: Name, email: Email, birth: String, phoneNumber: PhoneNumber, interest: [String]) {
        self.name = name
        self.email = email
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.interest = interest
    }
}
