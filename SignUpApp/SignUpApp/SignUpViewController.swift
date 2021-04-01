//
//  SignUpViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/03/29.
//

import UIKit
import Combine

class SignUpViewController: UIViewController, EditViewControllerDelegate {
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
    private var textFieldPublisher: AnyCancellable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTextFields.first?.becomeFirstResponder()
        nextButton.isEnabled = false

        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [ID(), Password(), PasswordConfirm(), Name()]))
        setTextFieldSubscriber()
    }
    
    private func setTextFieldSubscriber() {
        textFieldPublisher = NotificationCenter.default
            .publisher(for: SignUpManager.NotificationName.didUpdateTextField)
            .sink { notification in
                DispatchQueue.main.async {
                    self.isEnableNextView(notification)
                }
            }
    }
    
    func mapping(by index: Int) -> Validatable? {
        return self.signUp.mapping(by: index)
    }
    
    func getIndex(textField: UITextField) -> Int? {
        return self.signUpTextFields.firstIndex(of: textField)
    }
    
    func getTextFieldText(index: Int) -> String {
        return self.signUpTextFields[index].text ?? ""
    }
    
    func setConditionLabelText(index: Int, condition: String) {
        self.conditionLabels[index].text = condition
    }
    
    func setConditionLabelColor(index: Int, color: UIColor) {
        self.conditionLabels[index].textColor = color
    }
    
    func getTextField(index: Int) -> UITextField? {
        return self.signUpTextFields[index]
    }
    
    private func isEnableNextView(_ notification: Notification) {
        guard let dict = notification.userInfo as Dictionary? else { return }
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
        let informationVC = self.storyboard?.instantiateViewController(withIdentifier: "InformaionViewController") as! InformaionViewController
        self.present(informationVC, animated: true, completion: nil)
    }
}

