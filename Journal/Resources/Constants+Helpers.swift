//
//  Constants.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

enum CellReuseIdentifiers: String {
    case entries = "EntryCell"
}

enum SegueIdentifiers: String {
    case toNewEntry = "NewEntry"
    case toEntryDetails = "EntryDetails"
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
