//
//  SimpleValidationVC.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

fileprivate let miniUserLength = 5
fileprivate let miniPwdLength = 6

class SimpleValidationVC: BaseController {

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var nameTipLabel: UILabel!
    @IBOutlet weak var pwdTipLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SimpleValidation"
        
        nameTipLabel.text = "Username has to be at least \(miniUserLength) characters"
        pwdTipLabel.text = "Password has to be at least \(miniPwdLength) characters"
        
        // make valid  Observable
        let userNameValid = nameTF.rx.text.orEmpty
            .map { $0.count >= miniUserLength }
            .share(replay: 1)
        
        let pwdValid = pwdTF.rx.text.orEmpty
            .map { $0.count >= miniPwdLength }
            .share(replay: 1)
        
        let allValid = Observable.combineLatest(userNameValid, pwdValid) { $0 && $1 }
            .share(replay: 1)
        
        // bind
        userNameValid
            .bind(to: pwdTF.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid
            .bind(to: nameTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        pwdValid
            .bind(to: pwdTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        allValid
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // tap subscribe
        loginBtn.rx.tap
            .subscribe(onNext: {
                [weak self] _ in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
