//
//  Preferences.swift
//  TimeFlies
//
//  Created by Vergil Choi on 2018/4/9.
//  Copyright © 2018年 Vergil Choi. All rights reserved.
//

import Cocoa

class Preferences: NSObject {

    private static let birthDateKey = "birth.date.key"
    
    var date: NSDate? {
        get {
            return UserDefaults.standard.object(forKey: Preferences.birthDateKey) as? NSDate
        }
        set {
            UserDefaults.standard.set(date, forKey: Preferences.birthDateKey)
        }
    }
    
}
