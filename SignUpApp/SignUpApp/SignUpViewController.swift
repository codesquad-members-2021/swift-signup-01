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
    @IBOutlet weak var nextButton: UIButton!
    
    private var signUp: SignUpManageable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTextFields.first?.becomeFirstResponder()
        nextButton.isEnabled = false

        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [ID(), Password(), PasswordConfirm(), Name()]))
        configureTextFieldObserver()
    }
    
    private func configureTextFieldObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(isEnableNextView(_:)), name: SignUpManager.NotificationName.didUpdateTextField, object: nil)
    }
    
    func mapping(by index: Int) -> Validatable? {
        return self.signUp.mapping(by: index)
    }
    
    @objc func isEnableNextView(_ notification: NSNotification) {
        guard let dict = notification.userInfo as NSDictionary? else { return }
        if let index = dict["index"] as? Int, let isValid = dict["isValid"] as? Bool {
            if self.signUp.isEnableNext(index: index, isVaild: isValid) {
                self.nextButton.isEnabled = true
                self.nextButton.backgroundColor = .systemGreen
            } else {
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = .darkGray
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

