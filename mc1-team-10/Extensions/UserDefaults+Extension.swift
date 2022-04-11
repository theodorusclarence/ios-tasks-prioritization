//
//  UserDefaults+Extension.swift
//  mc1-team-10
//
//  Created by Clarence on 11/04/22.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded:Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        } set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}
