//
//  Entry.swift
//  ios-journal-REST
//
//  Created by Lambda-School-Loaner-11 on 8/9/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    var title: String
    var bodyText: String
    var timestamp: Date
    var identifier: String
    
    init(title: String, bodyText: String, timestamp: Date, identifier: String) {
        
        self.title = title
        self.bodyText = bodyText
        self.timestamp = Date()
        self.identifier = UUID().uuidString
    }
}
