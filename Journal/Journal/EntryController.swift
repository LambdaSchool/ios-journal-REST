//
//  EntryController.swift
//  Journal
//
//  Created by Jocelyn Stuart on 1/24/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

class EntryController {
    var entries: [Entry] = []
    
    static var baseURL = URL(string: "https://journal-2869f.firebaseio.com/")!
    
    func put(withEntry entry: Entry, completion: @escaping (Error?) -> Void) {
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier)
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(entry)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.entries.append(entry)
            completion(nil)
            }.resume()
        
    }
    
    func createEntry(withTitle title: String, andBody bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        put(withEntry: entry) { (error) in
            if let error = error {
                print(error)
            }
        }
        
    }
    
    func delete(entry: Entry, completion: @escaping (Entry?) -> Void) {
        guard let index = entries.index(of: entry) else {return}
        
        completion(entries.remove(at: index))
        
        //how to delete the table view cell inside of the completion closure
        
    }
    
    func update(withEntry entry: Entry, andTitle title: String, andBody bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        entries[index].title = title
        entries[index].bodyText = bodyText
        
        put(withEntry: entry) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = EntryController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodedDict = try jsonDecoder.decode([String: Entry].self, from: data)
                let entries = Array(decodedDict.values)
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
