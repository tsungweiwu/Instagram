//
//  LoginViewController.swift
//  Instagram
//
//  Created by Tsung Wei Wu on 11/20/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 2.0
        static let textAlpha: CGFloat = 0.25
        static let borderAlpha: CGFloat = 0.4
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Username or Email...",
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
            string: "Enter password",
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(gray: 1, alpha: Constants.borderAlpha)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Forgot your login details? Get help signing in.", for: .normal)
        button.titleLabel?.font = UIFont(name: "Heiti TC", size: 13)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    private let orText: UITextView = {
        let text = UITextView()
        text.text = "OR"
        text.textColor = UIColor.white
        text.textAlignment = NSTextAlignment.center
        text.backgroundColor = UIColor.clear
        text.font = UIFont(name: "Heiti TC", size: 15)
        return text
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log in with Facebook", for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Don't have an account? Sign up", for: .normal)
        return button
    }()
    
    private let headerView: UIImageView = {
        // Add instagram logo
        let header = UIImageView(image: UIImage(named: "text"))
        header.contentMode = .scaleAspectFit
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(didTapForgotButton), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(didTapFacebookButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        // delegate when user hits enter button
        usernameEmailField.delegate = self
        passwordField.delegate = self
        orText.isScrollEnabled = false
        orText.isEditable = false
        orText.isSelectable = false
        
        assignBackground()
        // function that calls these UI fields
        addSubviews()
    }
    
    // subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        headerView.frame = CGRect(
            x: view.width/4,
            y: view.safeAreaInsets.top * 3,
            width: view.width/2,
            height: 100
        )
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 20,
            width: view.width - 50,
            height: 52.0
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 20,
            width: view.width - 50,
            height: 52.0
        )
        
        forgotButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 20,
            width: view.width - 50,
            height: 30.0
        )
        
        orText.frame = CGRect(
            x: 25,
            y: forgotButton.bottom,
            width: view.width - 50,
            height: 25.0
        )
        
        facebookButton.frame = CGRect(
            x: 25,
            y: orText.bottom + 5,
            width: view.width - 50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: view.bottom - 80,
            width: view.width - 50,
            height: 52.0
        )
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(forgotButton)
        view.addSubview(orText)
        view.addSubview(facebookButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
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
    
    // functions for four buttons
    @objc private func didTapLoginButton() {
        // dismiss keyboard
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        // check for text
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        // login functionality
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        }
        else {
            // username
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
//                    let vc = HomeViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
                else {
                    // error occured
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapForgotButton() {}
    
    @objc private func didTapFacebookButton() {}
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        vc.modalPresentationStyle = .fullScreen
    
        present(vc, animated: false)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}
