//
//  EntryController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class EntryController {
    private(set) var entries: [Entry] = []
    
    let baseURL = URL(string: "https://mcelhinneyjournal.firebaseio.com/")!
    
    // MARK: - CRUD Methods
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void ) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        entries.append(entry)
        put(entry: entry, completion: completion)
    }
    
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
    
    func deleteEntry(_ entry: Entry, completion: @escaping (Error?) -> Void ) {
        guard let index = entries.index(of: entry) else {
            completion(NSError())
            return
        }
        
        entries.remove(at: index)
        
        delete(entry: entry, completion: completion)
    }
    
    // MARK: - Networking Methods
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
                self.entries = decodedEntries.sorted() { $0.timestampCreated < $1.timestampCreated }
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
