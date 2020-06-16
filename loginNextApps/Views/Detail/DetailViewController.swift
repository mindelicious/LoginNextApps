//
//  DetailViewController.swift
//  loginNextApps
//
//  Created by Matt on 11/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailViewModel!
    lazy private var cardView = makeCardView()
    lazy private var mailLabel = makeLabel()
    lazy private var passwordLabel = makePasswordLabel()
    lazy private var showPasswordBtn = makeShowPasswordBtn()
    private var isVisible: Bool = false
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        isPasswordVisible(isVisible)
        viewModel.configureMailLabel(mailLabel)
        viewModel.configurePasswordLabel(passwordLabel)
    }
    
    // MARK: - Handle Tap Button
    @objc func showPassBtnTapped(sender: UIButton) {
        sender.pulse()
        isPasswordVisible(isVisible)
    }
    
    func isPasswordVisible(_ visible: Bool) {
        passwordLabel.isSecureTextEntry = !visible
        visible ? showPasswordBtn.setTitle("hide_password".localized(), for: .normal) : showPasswordBtn.setTitle("show_password".localized(), for: .normal)
        isVisible = !visible
    }
    
}

// MARK: - SetupUI & Constraints
extension DetailViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.sunset
        view.addSubview(cardView)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.sunset
        navigationController?.navigationBar.isTranslucent = false
        
        cardView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height / 1.7)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.bottom.equalTo(showPasswordBtn.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        showPasswordBtn.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.sunset
        label.numberOfLines = 0
        label.font = label.font.withSize(22)
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    func makePasswordLabel() -> UITextField {
        let label = UITextField()
        label.textColor = UIColor.sunset
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.isUserInteractionEnabled = false
        return label
    }
    
    func makeShowPasswordBtn() -> UIButton {
        let passBtn = UIButton()
        passBtn.backgroundColor = UIColor.sunset
        passBtn.setTitleColor(UIColor.midnightBlue, for: .normal)
        passBtn.addTarget(self, action: #selector(showPassBtnTapped), for: .touchUpInside)
        
        passBtn.layer.cornerRadius = 6
        return passBtn
    }
    
    func makeCardView() -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = UIColor.midnightBlue
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 6
        [mailLabel, passwordLabel, showPasswordBtn].forEach { cardView.addSubview($0) }
        return cardView
    }
    
}
