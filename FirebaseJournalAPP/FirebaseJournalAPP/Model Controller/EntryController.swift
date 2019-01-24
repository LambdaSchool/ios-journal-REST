//
//  EntryController.swift
//  FirebaseJournalAPP
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class EntryController {
    
    private(set) var entries: [Entry] = []
    
    private let baseURL = URL(string: "https://nelsonjournalapp.firebaseio.com/")!
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void){
      let url = baseURL.appendingPathComponent(entry.identifier)
        let newUrl = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: newUrl)
        urlRequest.httpMethod = HTTPMethods.put.rawValue
        
        let encoder = JSONEncoder()
        
        do {
           let entry = try encoder.encode(entry)
            urlRequest.httpBody = entry
        } catch {
            
                NSLog("Error encoding data: \(error)")
                completion(error)
                return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if error != nil {
                NSLog("Error getting request: \(error!.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
            
        }.resume()
    }
    
    // MARK: - CRUD
    
    // Create an entry
    func createEntry(with title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        put(entry: entry) { (error) in
            if error != nil {
                NSLog("Error creating entry: \(error!.localizedDescription)")
                completion(error)
            }
            completion(nil)
        }
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Error?) -> Void){
        guard let index = entries.index(of: entry) else {return}
        let entryToDelete = self.entries.remove(at: index)
        delete(entry: entryToDelete) { (error) in
            if error != nil {
                NSLog("Error deleting entry from table: \(error!.localizedDescription)")
                completion(error)
            }
            completion(nil)
        }
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else {return}
        entries[index].title = title
        entries[index].bodyText = bodyText
        
        let updatedEntry = entries[index]
        
        put(entry: updatedEntry) { (error) in
            if error != nil {
                NSLog("Error updating entry \(error!.localizedDescription)")
                completion(error)
            }
            completion(nil)
        }
    }
    
    func delete(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(entry.identifier)
        let newUrl = url.appendingPathExtension("json")
        
        var request = URLRequest(url: newUrl)
        request.httpMethod = HTTPMethods.delete.rawValue
        
        //encode the data
        let encoder = JSONEncoder()
        
        do {
          let encodedEntry = try encoder.encode(entry)
            request.httpBody = encodedEntry
            completion(nil)
        } catch {
            NSLog("Error encoding the data \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting entry: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
        
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                NSLog("Error: \(error!.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data: \(error!.localizedDescription)")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedEntries = try decoder.decode([String: Entry].self, from: data)
                //get each [Entry] values
                let values = decodedEntries.map{ $0.value }
                let theSortedValues = values.sorted(by: { ($0.timestamp < $1.timestamp)})
                self.entries = theSortedValues
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
        }.resume()
    }
}
