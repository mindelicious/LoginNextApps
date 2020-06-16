//
//  LoginViewController.swift
//  loginNextApps
//
//  Created by Matt on 11/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: LoginViewModel = LoginViewModel()
    lazy private var mailTextField = makeMailTextField()
    lazy private var passwordTextField = makePasswordTextField()
    lazy private var loginBtn = makeLoginBtn()
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        enableLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @objc func loginBtnTapped(sender: UIButton) {
        sender.pulse()
        //delay zrobiony dlatego że wpisaniu loginu i hasła będą sprawdzane dane
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.view.endEditing(true)
            let detailVC = DetailViewController()
            detailVC.viewModel = DetailViewModel(credentials: self.viewModel.credentials)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // MARK: - Helper functions
    func enableLoginButton() {
        mailTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
    }
    
    @objc func validateTextField() {
        guard let mailText = mailTextField.text, let passText = passwordTextField.text else { return }
        viewModel.setCredentials(mail: mailText, password: passText)
        isLoginButtonEnable(viewModel.validate())
    }
    
    func isLoginButtonEnable(_ enable: Bool) {
        loginBtn.isEnabled = enable
        loginBtn.alpha = enable ? 1 : 0.5
    }
    
    // MARK: - Handle Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  else { return }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height / 3
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
}

// MARK: - SetupUI & Constraints
extension LoginViewController {
    
    func setupUI() {
        setBackButtonItem()
        mailTextField.delegate = self
        passwordTextField.delegate = self
        [mailTextField, passwordTextField, loginBtn].forEach { view.addSubview($0)}
        passwordTextField.isSecureTextEntry = true
        view.backgroundColor = UIColor.midnightBlue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        mailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.height.equalTo(40)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
        }
    }
    
    func setBackButtonItem() {
        let uiBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "back".localized(),
                                                               style: .plain,
                                                               target: nil,
                                                               action: nil)
        uiBarButtonItem.tintColor = UIColor.midnightBlue
        navigationItem.backBarButtonItem = uiBarButtonItem
    }
    
    func makeMailTextField() -> UITextField {
        setupTextField(icon: "mail", placeholder: "email_address".localized())
    }
    
    func makePasswordTextField() -> UITextField {
        setupTextField(icon: "password", placeholder: "enter_password".localized())
    }
    
    func makeLoginBtn() -> CustomButton {
        let loginBtn = CustomButton(title: "login".localized(),
                                    cornerRadius: 6,
                                    backgroundColor: UIColor.sunset!,
                                    titleColor: UIColor.midnightBlue!,
                                    btnState: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        loginBtn.isEnabled = false
        loginBtn.alpha = 0.5
        
        return loginBtn
    }
    
    func textFieldIcon(_ iconName: String) -> UIView {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        let image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.blueSteel
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.isUserInteractionEnabled = false
        return button
    }
    
    func setupTextField(icon: String, placeholder: String) -> UITextField {
        let loginTextField = UITextField()
        loginTextField.textColor = UIColor.white
        loginTextField.autocapitalizationType = .none
        
        loginTextField.leftViewMode = .always
        loginTextField.leftView = textFieldIcon(icon)
        
        loginTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueSteel!])
        return loginTextField
    }
    
}
