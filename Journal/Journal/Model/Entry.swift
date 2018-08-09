//
//  Entry.swift
//  Journal
//
//  Created by Carolyn Lea on 8/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable
{
    var title: String
    var bodyText: String
    let timeStamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timeStamp: Date = Date(), identifier:String = UUID().uuidString)
    {
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
        self.identifier = identifier
    }
}
