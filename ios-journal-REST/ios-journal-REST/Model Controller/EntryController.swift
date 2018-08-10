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
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        
        let entry = Entry(title: title, bodyText: bodyText)
        
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
        
        var update = Entry(title: title, bodyText: bodyText)
        
        update.timestamp = entry.timestamp
        update.identifier = entry.identifier
        
        guard let index = self.entries.index(of: entry) else { return }
        
        self.entries[index] = update
        self.put(entry: update, completion: completion)
        
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        
        let url = baseURL
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
                let entries = try JSONDecoder().decode([String : Entry].self, from: data)
                
                let entry = entries.map({$0.value})
                
                self.entries = entry
                
            } catch {
                NSLog("Error: \(error)")
            }
            completion(nil)
            
        }.resume()
        
        
    }
    
    func delete(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        guard let index = self.entries.index(of: entry) else { return }
        
        self.entries.remove(at: index)
        
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    
}
