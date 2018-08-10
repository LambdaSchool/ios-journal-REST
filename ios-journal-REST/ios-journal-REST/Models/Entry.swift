//
//  Entry.swift
//  ios-journal-REST
//
//  Created by Lambda-School-Loaner-11 on 8/9/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        
        return lhs.identifier == rhs.identifier
    }
    
    var title: String
    var bodyText: String
    var timestamp: Date
    var identifier: String
    
    init(title: String, bodyText: String) {
        
        self.title = title
        self.bodyText = bodyText
        self.timestamp = Date()
        self.identifier = UUID().uuidString
    }
}
