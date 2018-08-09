//
//  EntryController.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class EntryController {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var entries: [Entry] = []
    
    static let baseURL = URL(string: "https://journal-c0120.firebaseio.com/")!
    
    // PUT an existing entry
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        // How to know if you need to initialize a new Entry object, and append the encoded entry to the Entry variable?
        
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Unable to encode \(entry): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving entry to server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    // Create a new entry using the PUT method above
    func createEntry(withTitle title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        // Pass in completion of createEntry() into the completion closure of pull() - this will forward the completion of put() to the caller of createEntry() so the error can be handled there.
        
        put(entry: entry, completion: completion)
    }
    
    // Fetch the data using GET
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = EntryController.baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving entries from server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            do {
                let decodedEntries = try JSONDecoder().decode([String: Entry].self, from: data)
                let sortedDecodedEntries = decodedEntries.map { $0.value }.sorted { $0.timestamp < $1.timestamp }
                
                DispatchQueue.main.async {
                    self.entries = sortedDecodedEntries
                    completion(nil)
                }
            } catch {
                NSLog("Error decoding received data: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }.resume()
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        
        var entry = entries[index]
        entry.title = title
        entry.bodyText = bodyText
        
        entries.remove(at: index)
        entries.insert(entry, at: index)
        
        put(entry: entry, completion: completion)
    }
    
    // Delete
    func delete(entry: Entry, completion: @escaping (Error?) -> Void) {
//        guard let index = entries.index(of: entry)  else { return }
//        entries.remove(at: index)
        
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Don't care about the data, just want to delete
            if let error = error {
                NSLog("Error deleting entry from server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                guard let index = self.entries.index(of: entry) else {
                    NSLog("Something happened to the entry")
                    completion(NSError())
                    return
                }
                
                self.entries.remove(at: index)
                completion(nil)
            }
        }.resume()
    }
 }





