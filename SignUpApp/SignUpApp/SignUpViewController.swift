//
//  SignUpViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import UIKit
import Combine

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
    private var textFieldPublisher: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTextFields.first?.becomeFirstResponder()
        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [ID(), Password(), Password(), Name()]))
        setPhotosSubscriber()
    }
    
    private func setPhotosSubscriber() {
        textFieldPublisher = NotificationCenter.default
            .publisher(for: SignUpManager.NotificationName.didUpdateTextField)
            .sink { notification in
                DispatchQueue.main.async {
                    self.isEnableNextView(index: notification.object as! Int)
                }
            }
    }
    
    func mapping(by index: Int) -> Validatable? {
        return self.signUp.mapping(by: index)
    }
    
    func isEnableNextView(index: Int) {
        if self.signUp.isEnableNext(index: index) {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .systemGreen
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

