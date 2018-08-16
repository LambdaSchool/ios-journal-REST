//
//  Entry.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    
    var title: String
    var bodytext: String
    var timestamp: Date
    var identifier: String
    
    init(title: String, bodytext: String, timestamp: Date = Date(), identifier: String = UUID().uuidString){
        
        self.title = title
        self.bodytext = bodytext
        self.timestamp = timestamp
        self.identifier = identifier
        
    }
    
}
