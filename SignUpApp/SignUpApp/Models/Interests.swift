//
//  Interest.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class Interests: Validatable {
    private var interests: [String]
    
    init(interests: [String]) {
        self.interests = interests
    }
    convenience init() {
        let interests = [String]()
        self.init(interests: interests)
    }
    
    func isValid(input: String) -> (Bool, String) {
        return (true, "")
    }
    
    func saveProperty(input: String) {
        self.interests.append(input)
    }
}
