//
//  EntryController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    /// Private set property that holds the current entries
    private(set) var entries: [Entry] = []
    
    // Base URL for the API
    private let baseURL = URL(string: "https://mcelhinneyjournal.firebaseio.com/")!
    
    // MARK: - CRUD Methods
    /// Creates an entry from the given properties, appends it to the array and PUTs it to the API. Calls a completion handler when it is done.
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void ) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        entries.append(entry)
        put(entry: entry, completion: completion)
    }
    
    /// Updates the given entry with the given properties in the array and PUTs it to the API. Calls a completion handler when it is done.
    func update(_ entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void ) {
        guard let index = entries.index(of: entry) else {
            completion(NSError())
            return
        }
        
        entries[index].title = title
        entries[index].bodyText = bodyText
        entries[index].timestampUpdated = Date()
        
        put(entry: entries[index], completion: completion)
        
    }
    
    /// Deletes the given entry from the array and DELETEs it from the API. Calls a completion handler when it is done.
    func deleteEntry(_ entry: Entry, completion: @escaping (Error?) -> Void ) {
        guard let index = entries.index(of: entry) else {
            completion(NSError())
            return
        }
        
        entries.remove(at: index)
        
        delete(entry: entry, completion: completion)
    }
    
    // MARK: - Networking Methods
    /// Fetches the existing entries from the network and sets the entries array to the result. Calls a completion handler when it is done.
    func fetchEntries(completion: @escaping (Error?) -> Void ) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching entries: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            do {
                let entriesDictionary = try JSONDecoder().decode([String: Entry].self, from: data)
                let decodedEntries = entriesDictionary.map() { $0.value }
                self.entries = decodedEntries.sorted() { $0.timestampUpdated > $1.timestampUpdated }
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    /// Private method for handling the PUT requests
    private func put(entry: Entry, completion: @escaping (Error?) -> Void ) {
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Error encoding entry: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTting entry: \(error)")
                completion(error)
                return
            }
            
            guard data != nil else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            completion(nil)
            
        }.resume()
    }
    
    /// Private method for handling the DELETE requests.
    private func delete(entry: Entry, completion: @escaping (Error?) -> Void ) {
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTting entry: \(error)")
                completion(error)
                return
            }
            
            guard data != nil else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            completion(nil)
            
            }.resume()
    }
}
