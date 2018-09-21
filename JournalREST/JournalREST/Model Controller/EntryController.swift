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
    
    
    // MARK: REST function. PUT
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        // Create a request url
        var url = EntryController.baseURL.appendingPathComponent(entry.identifier)
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue // PUT method
        
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
    
    
    // MARK: REST function. DELETE
    
    func delete(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        // Create a request url of the entry
        var url = EntryController.baseURL.appendingPathComponent(entry.identifier)
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue // DELETE method
        
        // Encode data of the entry
        let encoder = JSONEncoder()

        do {
            let encodedEntry = try encoder.encode(entry)
            request.httpBody = encodedEntry
            completion(nil)
        } catch {
            NSLog("Error encoding data: \(error)")
            completion(error)
            return
        }
        
        // Create the task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error deleting entry: \(error)")
                completion(error)
                return
            }
            
            guard let index = self.entries.index(of: entry) else { return }
            self.entries.remove(at: index)
            
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
        let updatedEntry = entries[index]
        
        put(entry: updatedEntry, completion: completion)
    }
    
    // Delete the entry
    func deleteEntry(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        delete(entry: entry, completion: completion)
    }
    
    // REST Fetch functions
    
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
                let entryDictionary = try decoder.decode([String : Entry].self, from: data) // Key is String, value is Entry
                let values = entryDictionary.map { $0.value } // Get [Entry] values
                let sortedData = values.sorted() { $0.timestmap < $1.timestmap} // Sort [Entry] by time
                self.entries = sortedData
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
