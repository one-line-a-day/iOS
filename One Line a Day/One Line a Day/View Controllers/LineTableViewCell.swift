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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        
        let month = dateFormatter.string(from: line.date)
        let day = dayFormatter.string(from: line.date)
        
        dayLabel.text = day
        dateLabel.text = month
        lineLabel.text = line.line
    }
    
    // MARK: - Properties
    
    var line: Line? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lineLabel: UILabel!
}
