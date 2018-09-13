//
//  Entry.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    var title: String
    var bodyText: String
    let timestampCreated: Date
    var timestampUpdated: Date
    let identifier: String
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestampCreated = Date()
        self.timestampUpdated = self.timestampCreated
        self.identifier = UUID().uuidString
    }
}
