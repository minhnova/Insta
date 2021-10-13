//
//  UploadPhotoController.swift
//  Insta
//
//  Created by Phai Hoang on 10/10/21.
//

import Foundation
import UIKit
import SnapKit


protocol UploadPostControllerDelegate: AnyObject {
    func didFinshUploadPost(controller :UIViewController)
}
class UploadPostController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: UploadPostControllerDelegate?
    
    var currentUser: User?
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    private let characterCountLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.text = "0/100"
        return lb
    }()
    
    private let photoImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var postCaption: CustomTextView = {
        let tv = CustomTextView()
        tv.placeHolderText = "Enter caption here"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()
    
 
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - API
    
    func uploadPost() {
        guard let img = selectedImage else { return }
        guard let user = self.currentUser else { return }
        self.showLoader(true)
        
        PostService.uploadPost(caption: self.postCaption.text, image: img, user: user) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG - post error \(error.localizedDescription)")
                return
            }
            self.delegate?.didFinshUploadPost(controller: self)
                
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapShareButton))
        
        self.view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.layer.cornerRadius = 10
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        
        self.view.addSubview(postCaption)
        postCaption.backgroundColor = .white
        postCaption.layer.borderColor = UIColor.lightGray.cgColor
        postCaption.layer.borderWidth  = 0.5
        postCaption.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(64)
        }
        
        self.view.addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints { make in
            make.right.equalTo(postCaption.snp.right)
            make.bottom.equalTo(postCaption.snp.bottom)
        }
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if(textView.text.count > 100) {
            textView.deleteBackward()
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapShareButton() {
        print("DEBUG - Did tap share")
        uploadPost()
    }
}

extension UploadPostController: UITextViewDelegate {
    

    func textViewDidChange(_ textView: UITextView) {
        print("DEBUG - textViewDidChange")
        checkMaxLength(textView)
        let count = textView.text.count
        
        characterCountLabel.text = "\(count)/10"
        
    }
}
