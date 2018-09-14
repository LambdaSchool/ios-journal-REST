//
//  Constants.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

enum CellReuseIdentifiers: String {
    case journals = "JournalCell"
    case entries = "EntryCell"
}

enum SegueIdentifiers: String {
    case toNewEntry = "NewEntry"
    case toEntriesList = "EntriesList"
    case toEntryDetails = "EntryDetails"
}
