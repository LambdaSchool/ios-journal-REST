//
//  EntryController.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class EntryController {
    
    // Put or update an entry in Firebase
    func put(with entry: Entry, completion: @escaping (Error?) -> (Void)) {
        let requestUrl = baseURL.appendingPathComponent(entry.identifier).appendingPathComponent(".json")
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let encodedEntry = try JSONEncoder().encode(entry)
            request.httpBody = encodedEntry
            
            let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error PUTing entry in Firebase: \(error)")
                    completion(error)
                }
                
                self.entries.append(entry)
                
                NSLog("PUT successful")
                completion(nil)
                
                }.resume()
            
        } catch {
            NSLog("Error encoding data: \(error)")
            completion(error)
        }
    }
    
    
    // Create a new entry instance and PUT it in Firebase
    func createEntry(with title: String, bodyText: String, completion: @escaping (Error?) -> (Void)) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        put(with: entry) { (error) -> (Void) in
            completion(error)
        }
    }
    
    func delete(entry: Entry, completion: @escaping (Error?) -> (Void)) {
        let requestUrl = baseURL.appendingPathComponent(entry.identifier).appendingPathComponent(".json")
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        do {
            let encodedEntry = try JSONEncoder().encode(entry)
            request.httpBody = encodedEntry
            
            let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error DELETEing entry in Firebase: \(error)")
                    completion(error)
                }
                
                NSLog("DELETE successful")
                guard let index = self.entries.index(of: entry) else { return }
                self.entries.remove(at: index)
                completion(nil)
                
                }.resume()
            
        } catch {
            NSLog("Error encoding data: \(error)")
            completion(error)
        }
    }
    
    
    // Update an existing entry with new data
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> (Void)) {
        guard let index = entries.index(of: entry) else { return }
        
        entries[index].title = title
        entries[index].bodyText = bodyText
    }
    
    
    // Fetch entries from Firebase
    func fetchEntries(completion: @escaping (Error?) -> (Void)) {
        let requestUrl = baseURL.appendingPathComponent(".json")
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting data from Firebase: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data found with the request.")
                completion(NSError())
                return
            }
            
            do {
                let getRequest = try JSONDecoder().decode([String: Entry].self, from: data)
                self.entries = getRequest.values.sorted(by: { (entry, entry2) -> Bool in
                    entry.timestamp.compare(entry2.timestamp) == .orderedDescending
                })
                completion(nil)
            } catch {
                NSLog("Error decoding GET data from Firebase: \(error)")
                completion(error)
            }
            
            }.resume()
    }
    
    
    var entries: [Entry] = []
    let baseURL = URL(string: "https://journal-jason-modisett.firebaseio.com/")!
    
}
