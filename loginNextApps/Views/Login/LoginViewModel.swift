//
//  LoginViewModel.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

class LoginViewModel {
    var credentials: Credentials
    
    init() {
        self.credentials = Credentials(login: nil, password: nil)
    }
    
    func setCredentials(mail: String, password: String) {
        credentials.login = mail
        credentials.password = password
    }
    
    func validate() -> Bool {
        guard let login = credentials.login, let password = credentials.password else { return false }
        return login.isValidEmail() && password.count >= 6
    }
    
}
