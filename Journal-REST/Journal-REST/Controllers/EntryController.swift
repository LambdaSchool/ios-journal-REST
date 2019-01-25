//
//  EntryController.swift
//  Journal-REST
//
//  Created by Moses Robinson on 1/24/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://fir-project-2cfa9.firebaseio.com/")!

enum httpMethod: String {
    case put = "PUT"
}

class EntryController {
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.put.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(entry)
        } catch {
            NSLog("error encoding entry")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("error trying to PUT data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        put(entry: entry, completion: completion)
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        guard let index = entries.index(of: entry) else { return }
        
        entries[index].title = title
        entries[index].bodyText = bodyText
        
        put(entry: entries[index], completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("unable to decode: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    let entriesDicrtionary = try jsonDecoder.decode([String: Entry].self, from: data)
                    let entries = entriesDicrtionary.map { $0.value }
                    self.entries = entries
                    completion(nil)
                } catch {
                    NSLog("could not decode data.")
                    completion(error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Properties
    
    private(set) var entries: [Entry] = []
}
