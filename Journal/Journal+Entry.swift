//
//  Journal+Entry.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

struct Journal: Equatable, Codable {
    let title: String
    var entries: [Entry]
}

struct Entry: Equatable, Codable {
    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = Date()
        self.identifier = UUID().uuidString
    }
}
