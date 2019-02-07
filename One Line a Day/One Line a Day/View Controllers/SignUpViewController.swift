//
//  SignUpViewController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.isHidden = true
        signupLabel.isHidden = true
        title = "Log In"
        
        guard AuthenticationHelper.currentUser != nil else { return }
        
        performSegue(withIdentifier: "ShowLines", sender: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        title = "Sign Up"
        signupLabel.isHidden = true
        UITextField.animate(withDuration: 0.2) {
            self.emailTextField.isHidden = false
        }
        
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else { return }
        
        let userLogin = username+password
        
        AuthenticationHelper.setCurrentUser(to: userLogin)
        
        performSegue(withIdentifier: "ShowLines", sender: nil)
    }
    
    @IBAction func logIn(_ sender: Any) {
        title = "Log In"
        
        if !emailTextField.isHidden {
            UITextField.animate(withDuration: 0.2) {
                self.emailTextField.isHidden = true
            }
        }
        
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        signupLabel.isHidden = false
    }
    
    // MARK: - Properties
    
    
    var user: User?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signupLabel: UILabel!
}
