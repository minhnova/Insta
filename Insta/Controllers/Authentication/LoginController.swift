//
//  LoginController.swift
//  Insta
//
//  Created by Phai Hoang on 10/3/21.
//

import Foundation
import UIKit
import SnapKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
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
    
    private lazy var loginButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("Login", for: .normal)
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        bt.setHeight(50)
        bt.layer.cornerRadius = 5

        bt.setTitleColor(UIColor(white: 1.0, alpha: 0.6), for: .normal)
        bt.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        bt.isEnabled = false

        return bt
    }()
    
    private lazy var forgotPassword: UIButton = {
        var bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in")
        bt.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        bt.setHeight(50)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    private lazy var dontHaveAccount: UIButton = {
        var bt = UIButton(type: .system)
        bt.attributedTitle(firstPart: "Dont have an account?", secondPart: "Sign up")
        bt.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        bt.setHeight(50)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureObserver()
    }
    
    var loginViewModel = LoginViewModel()
    
    // MARK: - API
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG - login fail \(error.localizedDescription)")
                return
            }
            let vc = MainTabController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        self.applyGradient()
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.size.equalTo(CGSize(width: 120, height: 80))
        }
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,loginButton,forgotPassword])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(32)
            make.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
        
        view.addSubview(dontHaveAccount)
        dontHaveAccount.snp.makeConstraints { make in
            make.bottom.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
        

    }
    
    func configureObserver() {
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc func didTapLogin() {
        print("DEBUG  didtaplogin")
    }
    
    @objc func handleSignUp() {
        let vc = RegistrationController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if (sender == emailTextField) {
            self.loginViewModel.email = sender.text
        } else {
            self.loginViewModel.password = sender.text
        }
        
        updateForm()

    }
}


extension LoginController: FormViewModel {
    func updateForm() {
        print("DEBUG  didtaplogin")
        loginButton.setTitleColor(self.loginViewModel.buttonTitleColor, for: .normal)
        loginButton.backgroundColor = self.loginViewModel.buttonBackgroundColor
        loginButton.isEnabled = self.loginViewModel.isFormValid
    }
    
    
}
