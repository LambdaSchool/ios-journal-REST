//
//  Entry.swift
//  JournalREST
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    
    // MARK: Properties
    
    var title: String
    var bodyText: String
    let timestmap: Date
    let identifier: String
    
    
    // MARK: Initializer
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestmap = Date()
        self.identifier = UUID().uuidString
    }
}
