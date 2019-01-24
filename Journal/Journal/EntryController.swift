//
//  EntryController.swift
//  Journal
//
//  Created by Nathanael Youngren on 1/24/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class EntryController {
    
    var entries: [Entry] = []
    
    let baseURL = URL(string: "https://lambda-journal.firebaseio.com/")!
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        let entryURL = baseURL.appendingPathComponent(entry.identifier)
        let jsonURL = entryURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: jsonURL)
        urlRequest.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(entry)
            urlRequest.httpBody = data
            completion(nil)
        } catch {
            print(NSError())
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        put(entry: newEntry) { (error) in
            completion(error)
            return
        }
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let entryIndex = entries.index(of: entry) else { return }
    
        entries[entryIndex].title = title
        entries[entryIndex].bodyText = bodyText
    
        let updatedEntry = entries[entryIndex]
        
        put(entry: updatedEntry) { (error) in
            completion(error)
            return
        }
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error retrieving data.")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode([String: Entry].self, from: data)
                let decodedEntries = decodedData.map({ $0.value })
                let sortedEntries = decodedEntries.sorted(by: { $0.timestamp > $1.timestamp })
                self.entries = sortedEntries
                completion(nil)
            } catch {
                print(error)
                completion(error)
                return
            }
            
        }.resume()
    }
}
