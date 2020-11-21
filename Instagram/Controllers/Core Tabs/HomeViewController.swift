//
//  ViewController.swift
//  Instagram
//
//  Created by Tsung Wei Wu on 11/20/20.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show login
            let loginCV = LoginViewController()
            // disable swipe away
            loginCV.modalPresentationStyle = .fullScreen
            present(loginCV, animated: false)
        }
    }

}

