//
//  AuthenticationViewModels.swift
//  Insta
//
//  Created by Phai Hoang on 10/4/21.
//

import Foundation
import UIKit


protocol FormViewModel {
    func updateForm()
}
protocol AuthenticationViewModel {
    var isFormValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}
struct LoginViewModel:AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return isFormValid ? UIColor.systemBlue: UIColor(white: 1.0, alpha: 0.3)
    }
    
    var buttonTitleColor: UIColor {
        return isFormValid ? UIColor.white : UIColor(white: 1.0, alpha: 0.6)
    }
    
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var isFormValid: Bool {
        return email?.isEmpty == false &&
               password?.isEmpty == false  &&
        fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isFormValid ? UIColor.systemBlue: UIColor(white: 1.0, alpha: 0.3)
    }
    
    var buttonTitleColor: UIColor {
        return isFormValid ? UIColor.white : UIColor(white: 1.0, alpha: 0.6)
    }
    

}
