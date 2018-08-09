//
//  Entry.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
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
