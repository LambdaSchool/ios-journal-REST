//
//  JournalController.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class JournalController {
    
    // MARK: - Properties
    /// Private set property that holds the current journals
    private(set) var journals: [Journal] = []
    
    /// Computed property that returns a sorted array of journals
    var sortedJournals: [Journal] {
        return journals.sorted() { $0.title < $1.title }
    }
    
    // Base URL for the API
    private let baseURL = URL(string: "https://mcelhinneyjournal.firebaseio.com/")!
    
    // MARK: - CRUD Methods
    func createJournal(title: String, completion: @escaping (Error?) -> Void ) {
        let journal = Journal(title: title)
        
        journals.append(journal)
        put(journal: journal, completion: completion)
    }
    
    /// Creates an entry from the given properties, appends it to the given journal and PUTs it to the API. Calls a completion handler when it is done.
    func createEntry(journal: Journal, title: String, bodyText: String, completion: @escaping (Error?) -> Void ) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        journal.entries.append(entry)
        put(journal: journal, completion: completion)
    }
    
    /// Updates the given entry with the given properties in the given journal and PUTs it to the API. Calls a completion handler when it is done.
    func update(journal: Journal, entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void ) {
        guard let index = journal.entries.index(of: entry) else {
            completion(NSError())
            return
        }
        
        journal.entries[index].title = title
        journal.entries[index].bodyText = bodyText
        journal.entries[index].timestampUpdated = Date()
        
        put(journal: journal, completion: completion)
        
    }
    
    func deleteJournal(_ journal: Journal, completion: @escaping (Error?) -> Void ) {
        guard let index = journals.index(of: journal) else {
            completion(NSError())
            return
        }
        
        journals.remove(at: index)
        delete(journal: journal, completion: completion)
    }
    
    /// Deletes the given entry from the array and DELETEs it from the API. Calls a completion handler when it is done.
    func deleteEntry(journal: Journal, entry: Entry, completion: @escaping (Error?) -> Void ) {
        guard let index = journal.entries.index(of: entry) else {
            completion(NSError())
            return
        }
        
        journal.entries.remove(at: index)
        
        put(journal: journal, completion: completion)
    }
    
    // MARK: - Networking Methods
    /// Fetches the existing entries from the network and sets the entries array to the result. Calls a completion handler when it is done.
    func fetchJournals(completion: @escaping (Error?) -> Void ) {
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
                let journalsDictionary = try JSONDecoder().decode([String: Journal].self, from: data)
                let journals = journalsDictionary.map() { $0.value }
                self.journals = journals
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    /// Private method for handling the PUT requests
    private func put(journal: Journal, completion: @escaping (Error?) -> Void ) {
        var requestURL = baseURL.appendingPathComponent(journal.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(journal)
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
    private func delete(journal: Journal, completion: @escaping (Error?) -> Void ) {
        var requestURL = baseURL.appendingPathComponent(journal.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error DELETEing entry: \(error)")
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
