//
//  DetailViewModel.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

class DetailViewModel {
    var credentials: Credentials
    
    init(credentials: Credentials) {
        self.credentials = credentials
    }
    
    func configureMailLabel(_ mailLabel: UILabel) {
        guard let login = credentials.login else { return }
        mailLabel.text = String(format: "login_introduction".localized(), login)
    }
    
    func configurePasswordLabel(_ passwordLabel: UITextField) {
        passwordLabel.text = credentials.password
    }
}
