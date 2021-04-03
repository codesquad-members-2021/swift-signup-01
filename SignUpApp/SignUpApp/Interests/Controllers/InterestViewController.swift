//
//  InterestViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit
import Combine

class InterestViewController: UIViewController, EditViewControllerDelegate {

    @IBOutlet weak var interestTextField: UITextField! {
        didSet {
            interestTextField.delegate = textFieldDelegate
            interestTextField.returnKeyType = .next
        }
    }
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    private var signUp: SignUpManageable!
    var user: UserManageable!
    private lazy var textFieldDelegate = TextFieldDelegate(self)
    private var interestDataSource: InterestDataSource!
    private var interestsPublisher: AnyCancellable!
    private let serverURL = "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interestDataSource = InterestDataSource()
        collectionView.dataSource = interestDataSource
        signUp = SignUpManager(userManageable: self.user, textFieldMapper: TextFieldMapper(userInfos: [Interest()]))
        setInterestsPublisher()
    }
    
    private func setInterestsPublisher() {
        interestsPublisher = NotificationCenter.default
            .publisher(for: SignUpManager.NotificationName.didUpdateInterests)
            .sink { notification in
                DispatchQueue.main.async {
                    self.updateInterests(notification)
                }
            }
    }
    
    func mapping(by index: Int) -> Validatable? {
        return self.signUp.mapping(by: index)
    }
    
    func getIndex(textField: UITextField) -> Int? {
        return 0
    }
    
    func getTextFieldText(index: Int) -> String {
        return self.interestTextField.text ?? ""
    }
    
    func setConditionLabelText(index: Int, condition: String) {
        self.conditionLabel.text = condition
    }
    
    func setConditionLabelColor(index: Int, color: UIColor) {
        self.conditionLabel.textColor = color
    }
    
    func getTextField(index: Int) -> UITextField? {
        return self.interestTextField
    }
    
    private func updateInterests(_ notification: Notification) {
        guard let dict = notification.userInfo as Dictionary? else { return }
        if let interest = dict["text"] as? String {
            self.signUp.appendInterest(input: interest)
            self.isEnableNextView(interestsCount: self.signUp.readInterestCount())
            self.interestDataSource = InterestDataSource(interests: self.signUp.readInterests())
            self.collectionView.dataSource = self.interestDataSource
            self.collectionView.reloadData()
        }
    }
    
    private func isEnableNextView(interestsCount: Int) {
        if interestsCount >= 3 {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .systemGreen
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .darkGray
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        NetworkHandler.postSource(from: serverURL, json: self.signUp.getInfo()) { (networkResult, error) in
            if networkResult?.status == "200" {
                let pricvacyVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(pricvacyVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: .none)
    }
}
