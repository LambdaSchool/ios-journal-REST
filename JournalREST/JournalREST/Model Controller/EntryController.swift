//
//  EntryController.swift
//  JournalREST
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    
    var entries: [Entry] = []
    
    
    // MARK: - Base URL
    
    static let baseURL = URL(string: "https://journal-b5918.firebaseio.com/")!
    
    
    // MARK: Encode PUT method
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        // Create a request url
        var url = EntryController.baseURL.appendingPathComponent(entry.identifier)
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        // Encode data
        let encoder = JSONEncoder()
        
        do {
            let encodedEntry = try encoder.encode(entry)
            request.httpBody = encodedEntry
            completion(nil)
        } catch {
            NSLog("Error encoding \(entry): \(error)")
            completion(error)
            return
        }
        
        // Create a task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // Handle errors
            if let error = error {
                NSLog("Error transfering data: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    
    // MARK: - CRUD
    
    // Create an entry
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        put(entry: newEntry, completion: completion)
    }
    
    // Update the entry
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        
        entries[index].title = title
        entries[index].bodyText = bodyText
        
        put(entry: entry, completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        
        // Creata a url
        let url = EntryController.baseURL.appendingPathExtension("json")
        
        // Default method is GET so don't need to set the httpMehod
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            // Check if there ia a data
            guard let data = data else {
                NSLog("No data returned")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert keys from snake_case to camelCase
            
            do {
                let decodedEntry = try decoder.decode([Entry].self, from: data)
                let sortedData = decodedEntry.sorted() { $0.title < $1.title}
                self.entries = sortedData
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }
    }
}
