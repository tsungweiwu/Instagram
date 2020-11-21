//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Tsung Wei Wu on 11/20/20.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 2.0
        static let textAlpha: CGFloat = 0.25
        static let borderAlpha: CGFloat = 0.4
    }
    
    private let fullnameField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Full Name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.textColor = UIColor.white
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor(white: 1, alpha: Constants.textAlpha)
        return field
    }()
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.textColor = UIColor.white
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor(white: 1, alpha: Constants.textAlpha)
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.textColor = UIColor.white
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor(white: 1, alpha: Constants.textAlpha)
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        // show asterisk instead of text
        field.isSecureTextEntry = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.textColor = UIColor.white
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor(white: 1, alpha: Constants.textAlpha)
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(gray: 1, alpha: Constants.borderAlpha)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Already have an account? Sign in", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        // Do any additional setup after loading the view.
        assignBackground()
        
        fullnameField.delegate = self
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(fullnameField)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }
    
    private func assignBackground(){
           let background = UIImage(named: "gradient")

           var imageView : UIImageView!
           imageView = UIImageView(frame: view.bounds)
           imageView.contentMode =  UIView.ContentMode.scaleAspectFill
           imageView.clipsToBounds = true
           imageView.image = background
           imageView.center = view.center
           view.addSubview(imageView)
           self.view.sendSubviewToBack(imageView)
       }
    
    @objc private func didTapRegister() {
        
        fullnameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let fullname = fullnameField.text, !fullname.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(fullname: fullname, username: username, email: email, password: password) { (registered) in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
                else {
                    // failed
                    let alert = UIAlertController(title: "Sign Up Error", message: "Failed to register.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapLogin() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
    
        present(vc, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fullnameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        usernameField.frame = CGRect(x: 20, y: fullnameField.bottom + 10, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
        loginButton.frame = CGRect(x: 25, y: view.bottom - 80, width: view.width - 50, height: 52.0)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullnameField {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegister()
        }
        return true
    }
}
