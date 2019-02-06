//
//  NoteTableViewCell.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {
    
    private func updateViews() {
        guard let line = line else {return}
        
        dateLabel.text = line.date
        lineLabel.text = line.line
    }
    
    // MARK: - Properties
    
    var line: Line? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lineLabel: UILabel!
}
