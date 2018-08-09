//
//  EntryController.swift
//  Journal
//
//  Created by Carolyn Lea on 8/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://classjournal-6553b.firebaseio.com/")!

class EntryController
{
    // MARK: - Properties
    
    var entries: [Entry] = []
    
    
    // MARK: - PUT
    
    func put(entry:Entry, completion: @escaping (Error?) -> Void)
    {
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Unable to encode \(entry): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("Error saving messageThread on server: \(error)")
                completion(error)
                return
            }
            
            DispatchQueue.main.async {
                self.entries.append(entry)
                print(entry)
                completion(nil)
            }
        }
        .resume()
    }
    
    
    // MARK: - CRUD
    
    func createEntry(title: String, bodyText: String, timeStamp: Date, identifier:String, completion: @escaping (Error?) -> Void)
    {
        let entry = Entry(title: title, bodyText: bodyText, timeStamp: timeStamp, identifier: identifier)
        put(entry: entry, completion: completion)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
