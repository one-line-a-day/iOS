//
//  Note.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct Line: Codable, Equatable {
    
    var line: String
    var date: Date
    var identifier: String?
    var imgUrl: URL?
    
    init(line: String, date: Date = Date(), imgUrl: URL? = nil, identifier: String = UUID().uuidString) {
        (self.line, self.date, self.imgUrl, self.identifier) = (line, date, imgUrl, identifier)
    }
}

struct User: Codable, Equatable {
    
    var username: String
    var email: String
    var password: String
    var userLines: Lines?
    
    init(username: String, email: String, password: String) {
        (self.username, self.email, self.password) = (username, email, password)
    }
}

struct Lines: Codable, Equatable {
    var lines: [Line]
}
