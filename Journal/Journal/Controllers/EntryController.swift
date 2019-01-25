//
//  EntryController.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class EntryController {
    
    var entries: [Entry] = [] // to be used as the datasource for the class
    
    static let baseURL: URL = URL(string: "https://journal-angel.firebaseio.com/")!
    
    func put(entry : Entry, completion: @escaping (Error?) -> Void){
        var url = EntryController.baseURL
        url = url.appendingPathComponent(entry.identifier)
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(entry)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        entries.append(entry)
        
        put(entry: entry) { (completion) in
        }
    }
    
    func update(entry: Entry, title : String, bodyText : String, completion: @escaping (Error?) -> Void) {
        let oldEntry = entry
        var index = 0
        while index < entries.count {
            if entries[index] == oldEntry {
                entries[index].title = title
                entries[index].bodyText = bodyText
                put(entry: entry, completion: completion)
                 // may or may not be needed !!!!!!!!!!!!!!!
            }
            index += 1
        }
        put(entry: entry, completion: completion)
        //at the end of this method call the put Method to persist the change on the API
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        var url = EntryController.baseURL
        url = url.appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error. No data returned.")
                completion(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dictionary = try decoder.decode([String:Entry].self, from: data)
                
                let entries = Array(dictionary.values.sorted(by: {$0.timestamp > $1.timestamp}))
//                let entries = Array(dictionary.values)
                self.entries = entries
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }

}
