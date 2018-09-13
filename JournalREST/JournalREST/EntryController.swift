//
//  EntryController.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        putEntry(entry: entry, completion: completion)
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        
        let updatedEntry = Entry(title: title, bodyText: bodyText, timestamp: Date(), identifier: entry.identifier)
        entries.remove(at: index)
        entries.insert(updatedEntry, at: index)
        
        putEntry(entry: updatedEntry, completion: completion)
    }
    
    // MARK: - Networking
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let entryResults = try jsonDecoder.decode([String : Entry].self , from: data)
                
                let resultValues = entryResults.map( { $0.value } )
                let sortedKeys = resultValues.sorted(by: { (entry1, entry2) -> Bool in
                    return entry1.identifier > entry2.identifier
                })
               
                self.entries = sortedKeys
                print("Fetch successful")
                completion(nil)
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    func putEntry(entry: Entry, completion: @escaping (Error?) -> Void) {
        
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
                NSLog("Error PUTing entry: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not received from server")
                completion(NSError())
                return
            }
            
            let response = String(data: data, encoding: .utf8)!
            NSLog(response)
            
            self.entries.append(entry)
            completion(nil)
            
        }.resume()
    }
    
    // MARK: - Properties
    
    let baseURL = URL(string: "https://danielaparrajournal.firebaseio.com/")!
    
    var entries: [Entry] = []
}
