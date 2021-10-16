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
    
    let placeHolderLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.lightGray
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    var shouldCenterPlaceHolder = true {
        didSet {
            if shouldCenterPlaceHolder {
                placeHolderLabel.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.right.equalToSuperview().offset(8)
                }
            } else {
                placeHolderLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(8)
                    make.left.equalToSuperview().offset(8)
                }
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer) 
        addSubview(placeHolderLabel)

        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textViewDidChange() {
        self.placeHolderLabel.isHidden = !text.isEmpty
    }
}
