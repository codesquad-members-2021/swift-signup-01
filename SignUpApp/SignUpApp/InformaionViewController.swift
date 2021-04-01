//
//  InformaionViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit

class InformaionViewController: UIViewController, EditViewControllerDelegate {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var informationTextFields: [UITextField]!  {
        didSet {
            informationTextFields.forEach { textField in
                textField.delegate = textFieldDelegate
                textField.returnKeyType = .next
            }
        }
    }
    @IBOutlet var conditionLabels: [UILabel]!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var signUp: SignUpManageable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [Email(), PhoneNumber()]))
        
        informationTextFields.first?.becomeFirstResponder()
        nextButton.isEnabled = false
    }
    
    //MARK:- Delegate Method
    func mapping(by index: Int) -> Validatable? {
        return self.signUp?.mapping(by: index)
    }
    
    func getIndex(textField: UITextField) -> Int? {
        return self.informationTextFields.firstIndex(of: textField)
    }
    
    func getTextFieldText(index: Int) -> String {
        return self.informationTextFields[index].text ?? ""
    }
    
    func setConditionLabelText(index: Int, condition: String) {
        self.conditionLabels[index].text = condition
    }
    
    func setConditionLabelColor(index: Int, color: UIColor) {
        self.conditionLabels[index].textColor = color
    }
    
    func getTextField(index: Int) -> UITextField? {
        return self.informationTextFields[index]
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}
