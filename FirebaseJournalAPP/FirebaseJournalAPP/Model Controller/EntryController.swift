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
}
