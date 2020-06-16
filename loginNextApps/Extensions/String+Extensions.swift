//
//  String+Extensions.swift
//  loginNextApps
//
//  Created by Matt on 12/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import Foundation

extension String {
  
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
