//
//  CustomButton.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

//import UIKit
//
//class CustomButton: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? UIColor.sunsetHighlighted : UIColor.sunset
//        }
//    }
//
//    init(title: String,
//         cornerRadius: CGFloat,
//         backgroundColor: UIColor,
//         titleColor: UIColor,
//         btnState: UIButton.State) {
//        super.init(frame: .zero)
//
//        setTitle(title, for: .normal)
//        self.backgroundColor = backgroundColor
//        setTitleColor(titleColor, for: btnState)
//        layer.cornerRadius = cornerRadius
//    }
//
//}

//
//  CustomButton.swift
//  loginNextApps
//
//  Created by Matt on 13/06/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - Properties
    private var textButton: String?
    private lazy var activityIndicator = makeActivityIndicator(color: UIColor.midnightBlue!)
    
    // MARK: - Main
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
        setupUI()
    }
    
    // MARK: - Loading Indicator
    func loading(_ isLoading: Bool) {
        isEnabled = !isLoading

        if isLoading {
            textButton = titleLabel?.text
            setTitle("", for: .normal)
            activityIndicator.startAnimating()
        } else {
            setTitle(textButton, for: .normal)
            activityIndicator.stopAnimating()
        }
    }
    
}

 //MARK: - SetupUI & Constraints
extension CustomButton {

    func setupUI() {
        addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

    }

    func makeActivityIndicator(color: UIColor) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = color
        return activityIndicator
    }
}

