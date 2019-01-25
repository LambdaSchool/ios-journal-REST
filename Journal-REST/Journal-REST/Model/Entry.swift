//
//  Entry.swift
//  Journal-REST
//
//  Created by Moses Robinson on 1/24/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    
    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        (self.title, self.bodyText, self.timestamp, self.identifier) = (title, bodyText, timestamp, identifier)
    }
}
