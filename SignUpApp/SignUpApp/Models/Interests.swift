//
//  Interests.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class Interest: Validatable {
    private var interest: String
    
    init(interest: String) {
        self.interest = interest
    }
    convenience init() {
        let interest = String()
        self.init(interest: interest)
    }
    
    func isValid(input: String) -> (Bool, String) {
        return (true, "")
    }
    
    func saveProperty(input: String) {
        self.interest = input
    }
    
    func getInterest() -> String {
        return interest
    }
}

class Interests: InterestsManageable {
    private var interests: [Interest]
    
    init(interests: [Interest]) {
        self.interests = interests
    }
    convenience init() {
        let interests = [Interest]()
        self.init(interests: interests)
    }
    
    func count() -> Int {
        return self.interests.count
    }
    
    func getInterest(at indexPath: IndexPath) -> Interest {
        return self.interests[indexPath.item]
    }
    
    func appendInterest(input: String) {
        let interest = Interest(interest: input)
        self.interests.append(interest)
    }
    
    func getInterests() -> InterestsManageable {
        return Interests(interests: self.interests)
    }
}

protocol InterestsManageable {
    func count() -> Int
    func getInterest(at indexPath: IndexPath) -> Interest
    func getInterests() -> InterestsManageable
    func appendInterest(input: String)
}
