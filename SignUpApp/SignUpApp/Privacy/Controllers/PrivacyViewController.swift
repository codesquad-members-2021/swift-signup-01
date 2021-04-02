//
//  PrivacyViewController.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit

class PrivacyViewController: UIViewController {

    var user: UserManageable?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAgreeAlertControl()
    }
    
    private func configureAgreeAlertControl() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .systemGreen
        let agree = UIAlertAction(title: "동의", style: .default) { action in
            self.nextVC()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: .none)
        
        actionSheet.addAction(agree)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func nextVC() {
        let interestVC = self.storyboard?.instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
        interestVC.user = self.user
        self.present(interestVC, animated: true, completion: nil)
    }
}
