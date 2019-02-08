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
        updateViews()
    }
    
    @IBAction func done(_ sender: Any) {
        guard let lineString = lineView.text else { return }
        
        if let line = line {
            lineController?.updateLine(line: line, lineString: lineString, completion: { (error) in
                if let error = error {
                    NSLog("Could not create line: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.lineView.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else if !lineString.isEmpty {
            lineController?.createLine(lineString: lineString, completion: { (error) in
                if let error = error {
                    NSLog("Could not create line: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.lineView.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            self.lineView.endEditing(true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateViews() {
        if isViewLoaded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            
            guard let line = line else {
                lineView.becomeFirstResponder()
                let currentDate = dateFormatter.string(from: Date())
                navBar.topItem?.title = currentDate
                return }
            
            let dateFormatted = dateFormatter.string(from: line.date)
            
            navBar.topItem?.title = dateFormatted
            lineView.text = line.line
        }
    }
    
    // MARK: - Properties
    
    var line: Line? {
        didSet {
            updateViews()
        }
    }
    
    var lineController: LineController?
    
    @IBOutlet var lineView: UITextView!
    @IBOutlet var navBar: UINavigationBar!
}
