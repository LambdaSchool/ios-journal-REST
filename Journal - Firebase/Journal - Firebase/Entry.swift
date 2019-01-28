import Foundation

struct Entry: Equatable, Codable {
    
    var title: String
    var bodyText: String
    // The timestamp could be a variable if
    // it was based on modification date
    let timestamp: Date
    // The identifiers are unlikely to change
    // even it an entry is relocated
    // Workflowy handles things as such
    let identifier: String

    init(title: String, bodyText: String, timestamp: Date, identifier: String = UUID().uuidString) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }

}

