//
//  CustomTextField.swift
//  Insta
//
//  Created by Phai Hoang on 10/4/21.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("Can not be init")
    }
}
