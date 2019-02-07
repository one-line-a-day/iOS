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
        title = "Log In"
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        title = "Sign Up"
        UITextField.animate(withDuration: 0.2) {
            self.emailTextField.isHidden = false
        }
        
        guard let username = usernameTextField.text, !username.isEmpty,
        let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else { return }
        
        let user = User(username: username, email: email, password: password)
        users.append(user)
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        title = "Log In"
        
        if !emailTextField.isHidden {
            UITextField.animate(withDuration: 0.2) {
                self.emailTextField.isHidden = true
            }
        }
        
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let user = user else { return }
        
        let loggingUser = User(username: username, email: user.email, password: password)
        
        
        if users.contains(user) {
            AuthenticationHelper.setCurrentUser(to: user)
            performSegue(withIdentifier: "ShowLines", sender: nil)
        }
    }
    
    
    @IBAction func skipPage(_ sender: Any) {
        performSegue(withIdentifier: "ShowLines", sender: nil)
    }
    
    // MARK: - Properties
    
    var users: [User] = []
    
    var user: User?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
}
