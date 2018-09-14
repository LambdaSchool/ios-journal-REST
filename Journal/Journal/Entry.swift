//
//  Entry.swift
//  Journal
//
//  Created by Moin Uddin on 9/13/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    var title: String
    var bodyText: String
    var timestamp: Date
    var identifier: String
    
    init(title: String, bodyText: String, identifier: String = UUID().uuidString, timestamp: Date = Date()) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }
}
