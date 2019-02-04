//
//  Note.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct Line: Codable, Equatable {
    
    var text: String
    var date: Date
    var image: Data?
    
    init(text: String, date: Date = Date(), image: Data? = nil) {
        (self.text, self.date, self.image) = (text, date, image)
    }
}

struct User: Codable, Equatable {
    var username: String
    var email: String
    var password: String
    var notes: [Line]
}
