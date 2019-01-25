//
//  Entry.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    let title: String
    var bodyText: String
    var timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }
}
