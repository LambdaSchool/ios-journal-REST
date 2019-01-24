//
//  EntryController.swift
//  FirebaseJournalAPP
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class EntryController {
    
    private(set) var entries: [Entry] = []
    
    private let baseURL = URL(string: "https://nelsonjournalapp.firebaseio.com/")!
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void){
      let url = baseURL.appendingPathComponent(entry.identifier)
        let newUrl = url.appendingPathExtension("json")
    }
}
