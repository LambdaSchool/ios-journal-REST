//  Copyright © 2019 Frulwinn. All rights reserved.

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
