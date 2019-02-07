//
//  AuthenticationHelper.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/7/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

enum AuthenticationHelper {
    
    static func setCurrentUser(to user: User) {
        UserDefaults.standard.set(user, forKey: currentUserKey)
    }
    
    static var currentUser: User {
        return UserDefaults.standard.object(forKey: currentUserKey) as! User
    }
    
    static private let currentUserKey = "CurrentUser"
}
