//
//  RegistrationController.swift
//  Insta
//
//  Created by Phai Hoang on 10/3/21.
//

import Foundation
import UIKit
import SnapKit

class RegistrationController: UIViewController, UINavigationControllerDelegate {
    private var profileImge: UIImage?
    private lazy var addPhoto:UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        bt.setDimensions(height: 140, width: 140)
        bt.addTarget(self, action: #selector(addPhotoSelector), for: .touchUpInside)
        bt.backgroundColor = .none
        bt.tintColor = .white
        return bt
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Fullname")
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Username")
        return tf
    }()
    
    private lazy var signupButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Sign Up", for: .normal)
        bt.setTitleColor(UIColor(white: 1.0, alpha: 0.6), for: .normal)
        bt.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        bt.addTarget(self, action: #selector(userRegister), for: .touchUpInside)
        bt.setHeight(50)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    private lazy var alreadyHaveAccount: UIButton = {
        var bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "Already have an account?", secondPart: "Login")
       bt.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        bt.setHeight(50)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    var registrationViewModel = RegistrationViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureObserver()
    }
    
    // MARK: - Helpers
    func configureUI() {
        self.applyGradient()
        self.view.addSubview(addPhoto)
        addPhoto.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signupButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(addPhoto.snp.bottom).offset(32)
            make.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.snp.makeConstraints { make in
            make.bottom.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
    }
    
    func configureObserver() {
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Actions
    @objc func backToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if (sender == emailTextField) {
            self.registrationViewModel.email = sender.text
        } else if (sender == passwordTextField){
            self.registrationViewModel.password = sender.text
        } else if (sender == fullNameTextField){
            self.registrationViewModel.fullname = sender.text
        } else {
            self.registrationViewModel.username = sender.text
        }
        
        updateForm()

    }
    
    @objc func addPhotoSelector() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func userRegister() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        guard let username = userNameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImge else {return }
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImg: profileImage)
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG Register user Failed!: \(error.localizedDescription)")
                return
            }
            print("DEBUG Register user successfull!")
        }
    }
}

// MARK: FormViewModel

extension RegistrationController: FormViewModel {
    func updateForm() {
        signupButton.setTitleColor(self.registrationViewModel.buttonTitleColor, for: .normal)
        signupButton.backgroundColor = self.registrationViewModel.buttonBackgroundColor
        signupButton.isEnabled = self.registrationViewModel.isFormValid
    }
    
    
}

// MARK: UIImagePickerController Delegate

extension RegistrationController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        self.profileImge = selectedImage
        addPhoto.layer.cornerRadius = addPhoto.frame.width / 2
        addPhoto.layer.masksToBounds = true
        addPhoto.layer.borderColor = UIColor.white.cgColor
        addPhoto.layer.borderWidth = 2
        addPhoto.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
        
        
    }
}


