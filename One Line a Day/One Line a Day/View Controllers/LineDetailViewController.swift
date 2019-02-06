//
//  NoteDetailViewController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class LineDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineView.becomeFirstResponder()
    }

    @IBAction func done(_ sender: Any) {
        guard let lineString = lineView.text, !lineString.isEmpty else { return }
        
        lineController?.createLine(lineString: lineString, completion: { (error) in
            if let error = error {
                NSLog("Could not create line: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    
     // MARK: - Properties
    
    var line: Line?
    
    var lineController: LineController?

    @IBOutlet var lineView: UITextView!
}
