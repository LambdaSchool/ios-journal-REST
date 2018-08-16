//
//  Entry.swift
//  Journal
//
//  Created by Lisa Sampson on 8/16/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    var title: String
    var bodyText: String
    var timestamp: Date
    var identifier: String
    
    init(title: String, bodyText: String, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }
}
