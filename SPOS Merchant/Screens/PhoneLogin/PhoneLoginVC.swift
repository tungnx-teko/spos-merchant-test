//
//  PhoneLoginVC.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import Toast_Swift
import Janus

class PhoneLoginVC: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var otpField: UITextField!
    @IBOutlet weak var sendOTPButton: UIButton!
    @IBOutlet weak var otpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        sendOTPButton.isHidden = true
        otpLabel.isHidden = true
        otpField.isHidden = true
        
        
    }
    
    @IBAction func didTapOTP(_ sender: Any) {
        if phoneField.text?.count == 10 {
            PhoneAuthProvider.shared.requestOTP(phone: phoneField.text!) { [weak self] (isSuccess) in
                self?.otpLabel.isHidden = false
                self?.otpField.isHidden = false
                self?.view.makeToast("Đã gửi OTP")
            }
        } else {
            self.view.makeToast("Số điện thoại không hợp lệ")
        }
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        guard let otp = otpField.text else { return }
        if otp.count == 6 {
            do {
                guard let login = PhoneAuthProvider.shared.createPasswordlessLogin(pin: otp, delegate: self) else { return }
                try AuthLoginManager.shared.login(login)
            } catch {
                showAlert(title: "Có lỗi xảy ra", message: error.localizedDescription)
            }
        }
    }
    

}

extension PhoneLoginVC: AuthLoginDelegate {
    
    func loginSuccess(accessToken: String, refreshToken: String) {
        ClientManager.shared.accessToken = accessToken
        dismiss(animated: true, completion: nil)
    }
    
    func loginFail(message: String?) {
        showAlert(title: "Đăng nhập thất bại", message: message)
    }

}
