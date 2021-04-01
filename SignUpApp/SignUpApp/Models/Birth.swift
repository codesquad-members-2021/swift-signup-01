//
//  Birth.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import Foundation

class Birth: Validatable {
    private var birth: String
    
    init(birth: String) {
        self.birth = birth
    }
    
    convenience init() {
        let birth = ""
        self.init(birth: birth)
    }
    
    func isValid(input: String) -> (Bool, String) {
        return (true, "")
    }
    
    func saveProperty(input: String) {
        self.birth = input
    }
}
