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
        EntryController.baseURL.appendPathComponent(entry.identifier)
        EntryController.baseURL.appendPathExtension("json")
        
        var urlRequest = URLRequest(url: EntryController.baseURL)
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
    
}
