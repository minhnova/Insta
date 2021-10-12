//
//  CustomTextField.swift
//  Insta
//
//  Created by Phai Hoang on 10/11/21.
//

import UIKit
import SnapKit

class CustomTextView: UITextView {
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    private let placeHolderLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.lightGray
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer) 
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textViewDidChange() {
        self.placeHolderLabel.isHidden = !text.isEmpty
    }
}
