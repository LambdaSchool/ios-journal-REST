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
    
    func fetchEntries(completion: @escaping (Error?) -> Void)
    {
        let url = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("error \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let entriesDictionaries = try jsonDecoder.decode([String: Entry].self, from: data)
                let entries = entriesDictionaries.map({ $0.value }).sorted{ $0.timeStamp < $1.timeStamp }
                
                self.entries = entries
                
                
            } catch {
                NSLog("error \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    // MARK: - CRUD
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void)
    {
        let entry = Entry(title: title, bodyText: bodyText)
        put(entry: entry, completion: completion)
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void)
    {
        if let index = entries.index(of: entry)
        {
            var tempEntry = entry
            tempEntry.title = title
            tempEntry.bodyText = bodyText
            
            entries.remove(at: index)
            entries.insert(tempEntry, at: index)
            put(entry: tempEntry, completion: completion)
        }
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Error?) -> Void)
    {
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("error \(error)")
                completion(error)
                return
            }
            DispatchQueue.main.async {
                guard let index = self.entries.index(of: entry) else {
                    completion(NSError())
                    return
                }
                self.entries.remove(at: index)
                completion(nil)
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
