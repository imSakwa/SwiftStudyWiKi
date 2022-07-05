//
//  UserDefault+.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmakrs
    }
    
    var bookmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmakrs.rawValue) else { return [] }
            
            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }
        
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.bookmakrs.rawValue)
        }
    }
}
