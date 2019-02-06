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
    var date: String
    var imgUrl: URL?
    var dateData: Date?
    
    enum CodingKeys: String, CodingKey {
        case line
        case date
    }
    
    init(line: String, date: String, imgUrl: URL? = nil, dateData: Date = Date()) {
        (self.line, self.date, self.imgUrl, self.dateData) = (line, date, imgUrl, dateData)
    }
}

struct User: Codable, Equatable {
    
    var username: String
    var email: String
    var password: String
    var lines: [Line]
}
