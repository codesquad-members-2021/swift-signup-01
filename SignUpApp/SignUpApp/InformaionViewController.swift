//
//  InformaionViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit
import Combine

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
    
    private var signUp: SignUpManageable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    private var textFieldPublisher: AnyCancellable!
    private var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp = SignUpManager(userManageable: User(), textFieldMapper: TextFieldMapper(userInfos: [Birth() ,Email(), PhoneNumber()]))
        
        nextButton.isEnabled = false
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .autoupdatingCurrent
        
        createDatePicker()
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
    
    //MARK:- Date Picker Method
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: .none, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        informationTextFields.first?.inputAccessoryView = toolbar
        informationTextFields.first?.inputView = datePicker
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        informationTextFields.first?.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
    
    private func isEnableNextView(_ notification: Notification) {
        guard let dict = notification.userInfo as Dictionary? else { return }
        if let index = dict["index"] as? Int, let isValid = dict["isValid"] as? Bool {
            if self.signUp.isEnableNextInformation(index: index, isVaild: isValid) {
                self.nextButton.isEnabled = true
                self.nextButton.backgroundColor = .systemGreen
            } else {
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = .darkGray
            }
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}
