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
    @IBOutlet weak var nextButton: UIButton!
    
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTextFields.first?.becomeFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

