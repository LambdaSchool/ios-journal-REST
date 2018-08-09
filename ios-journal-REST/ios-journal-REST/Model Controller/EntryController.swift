//
//  EntryController.swift
//  ios-journal-REST
//
//  Created by Lambda-School-Loaner-11 on 8/9/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://journal-d5c9d.firebaseio.com/")!

class EntryController {
    
    private(set) var entries: [Entry] = []
    
    var entry: Entry!
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Error: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
    }
    
    func createEntry(title: String, bodyText: String, timestamp: Date, identifier: String, completion: @escaping (Error?) -> Void) {
        
        let entry = Entry(title: title, bodyText: bodyText, timestamp: timestamp, identifier: identifier)
        
        put(entry: entry) { (error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
            print(entry)
        }
        
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        
        var update = Entry(title: title, bodyText: bodyText, timestamp: entry.timestamp, identifier: entry.identifier)
        
        update.title = entry.title
        update.bodyText = entry.bodyText
        update.timestamp = entry.timestamp
        update.identifier = entry.identifier
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            do {
                let entries = try JSONDecoder().decode([String: [String: Entry]].self, from: data).values
                let entry = entries.flatMap({$0.values})
                
                self.entries = entry
                
            } catch {
                NSLog("Error: \(error)")
            }
            completion(nil)
            
        }.resume()
        
        
    }
    
    
    
    
    
    
}
