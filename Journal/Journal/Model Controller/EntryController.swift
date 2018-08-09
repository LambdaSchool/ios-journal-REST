//
//  EntryController.swift
//  Journal
//
//  Created by Jeremy Taylor on 8/9/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class EntryController {
    private(set) var entries: [Entry] = []
    private let baseURL = URL(string: "https://journal-88656.firebaseio.com/")!
    
    func put(entry:Entry, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        var entryData: Data?
        
        // Encode our entry into json.
        
        do {
            let jsonEncoder = JSONEncoder()
             entryData = try jsonEncoder.encode(entry)
        } catch {
            NSLog("Unable to encode entry data: \(error)")
            completion(error)
            return
        }
        request.httpBody = entryData
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTing entry to database: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func createEntry(withTitle title: String, andText text: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: text)
        put(entry: entry, completion: completion)
    }
    
    func updateEntry(entry: Entry, withTitle title: String, andText text: String, completion: @escaping (Error?) -> Void) {
        var newEntry = entry
        newEntry.title = title
        newEntry.bodyText = text
        put(entry: newEntry, completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching entries from the database: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from database")
                return
            }
            
            // We have json data decode it into Entry objects
            
            let jsonDecoder = JSONDecoder()
            
            do {
              let entries = try jsonDecoder.decode([Entry].self, from: data)
                self.entries = Array(entries).sorted(by: { $0.title < $1.title })
            } catch {
                NSLog("Unable to decode data into [Entry]: \(error)")
                self.entries = []
                completion(error)
                
            }
        }.resume()
        
    }
}
