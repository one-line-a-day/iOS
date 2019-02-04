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

    }
    
    @IBAction func skipPage(_ sender: Any) {
        performSegue(withIdentifier: "ShowLines", sender: nil)
    }
    
     // MARK: - Properties

}
