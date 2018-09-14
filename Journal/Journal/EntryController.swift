//
//  EntryController.swift
//  Journal
//
//  Created by Moin Uddin on 9/13/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


class EntryController {
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        var requestURL = baseURL
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error fetching entries \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            do {
                //Come back to sort
                let fetchedEntries = try JSONDecoder().decode([Entry].self, from: data)
                self.entries = fetchedEntries
            } catch {
                NSLog("Error getting data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            fatalError("Error encoding message \(entry): \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error posting new entry: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            self.entries.append(entry)
            print("Creating new Entry Successful")
            completion(nil)
        }.resume()

    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) ->  Void) {
        var updatedEntry = entry
        updatedEntry.title = title
        updatedEntry.bodyText = bodyText
        
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(updatedEntry)
        } catch {
            fatalError("Error encoding entry\(updatedEntry): \(error)")
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error updating entry: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            guard let index = self.entries.index(of: entry) else { return }
            self.entries[index] = updatedEntry
            print("Updating Entry Successful")
            completion(nil)
            }.resume()

        
    }
    
    var baseURL = URL(string: "https://moinjournal.firebaseio.com/")!
    var entries: [Entry] = []
}
