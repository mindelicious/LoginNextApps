//
//  Button+Extensions.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

extension UIButton {
    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 1.0
        pulse.toValue = 0.96
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.2
        pulse.damping = 0.2
        self.layer.add(pulse, forKey: "pulse")
    }
}
