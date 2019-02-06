//
//  NoteDetailViewController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class LineDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lineView.becomeFirstResponder()
    }

    @IBAction func done(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
     // MARK: - Properties

    @IBOutlet var lineView: UITextView!
}
