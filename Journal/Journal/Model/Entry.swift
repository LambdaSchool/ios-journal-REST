//
//  Entry.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable {
    
    // MARK: - Properties
    var title: String
    var bodyText: String
    let timestampCreated: Date
    var timestampUpdated: Date
    let identifier: String
    
    /// Computed property that returns a formatted string of the timestamp updated property.
    var formattedTimestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        
        return dateFormatter.string(from: timestampUpdated)
    }
    
    // MARK: - Initializers
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestampCreated = Date()
        self.timestampUpdated = self.timestampCreated
        self.identifier = UUID().uuidString
    }
}

class Journal: Codable, Equatable {
    
    // MARK: - Properties
    var title: String
    var identifier: String
    var entries: [Entry]
    
    /// Computed property that returns a sorted array of entries with the most recently updated first.
    var sortedEntries: [Entry] {
        return entries.sorted() { $0.timestampUpdated > $1.timestampUpdated }
    }
    
    // MARK: - Equatable
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // MARK: - Initializers
    init (title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.entries = []
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let entries = try container.decodeIfPresent([Entry].self, forKey: .entries)
        
        self.title = title
        self.identifier = identifier
        self.entries = entries ?? []
    }
}
