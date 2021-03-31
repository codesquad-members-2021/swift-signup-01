//
//  SignUpViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpTextFields: [UITextField]! {
        didSet {
            signUpTextFields.forEach { textField in
                textField.delegate = textFieldDelegate
                textField.returnKeyType = .next
            }
        }
    }
    @IBOutlet var conditionLabels: [UILabel]!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    
    private var signUp: SignUpManageable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTextFields.first?.becomeFirstResponder()
        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [ID(), Password(), Password(), Name()]))
    }
    
    func mapping(by index: Int) -> Validatable? {
        return self.signUp.mapping(by: index)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

