//
//  EntryController.swift
//  Journal
//
//  Created by Lisa Sampson on 8/16/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

class EntryController {
    
    func put(entry: Entry, completion: @escaping RequestCompletion) {
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            fatalError("Error encoding: \(entry) \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            completion(true)
            
            }.resume()
    }
    
    func createEntry(title: String, bodyText: String, completion: @escaping RequestCompletion) {
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        put(entry: newEntry, completion: completion)
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping RequestCompletion) {
        guard let index = entries.index(of: entry) else { return }
        
        var scratch = entries[index]
        scratch.title = title
        scratch.bodyText = bodyText
        
        entries.remove(at: index)
        entries.insert(entry, at: index)
        
        put(entry: entry, completion: completion)
    }
    
    func delete(entry: Entry, completion: @escaping RequestCompletion) {
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                guard let index = self.entries.index(of: entry) else {
                    NSLog("Can't find entry.")
                    completion(false)
                    return
                }
                
                self.entries.remove(at: index)
                completion(true)
            }
            }.resume()
    }
    
    func fetchEntries(completion: @escaping RequestCompletion) {
        let url = EntryController.baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not recieved.")
                completion(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedEntries = try jsonDecoder.decode([String: Entry].self, from: data)
                let entries = decodedEntries.map { $0.value }.sorted { $0.timestamp < $1.timestamp }
                self.entries = entries
                completion(true)
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(false)
                return
            }
            }.resume()
    }
    
    var entries: [Entry] = []
    static let baseURL = URL(string: "https://lambdaschooljournalapp.firebaseio.com/")!
    typealias RequestCompletion = (_ success: Bool) -> Void
    
}
