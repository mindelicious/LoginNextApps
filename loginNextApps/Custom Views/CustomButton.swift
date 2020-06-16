//
//  CustomButton.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.sunsetHighlighted : UIColor.sunset
        }
    }
    
    init(title: String,
         cornerRadius: CGFloat,
         backgroundColor: UIColor,
         titleColor: UIColor,
         btnState: UIButton.State) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: btnState)
        layer.cornerRadius = cornerRadius
    }
    
}
