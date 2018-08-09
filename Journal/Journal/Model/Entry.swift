//
//  Entry.swift
//  Journal
//
//  Created by Jeremy Taylor on 8/9/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timestamp: Date = Date(), identifier: String = UUID().uuidString) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
        
    }
}
