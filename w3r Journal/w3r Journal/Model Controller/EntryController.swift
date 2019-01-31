//
//  EntryController.swift
//  w3r Journal
//
//  Created by Michael Flowers on 1/31/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class EntryController {
    
    var entries: [Entry] = []
    
    let baseURL = URL(string: "https://journal1-66498.firebaseio.com/")!
    
    func updateEntry(with entry: Entry, newTitle: String, newBodyText: String, completion: @escaping (Error?) -> Void){
        entry.title = newTitle
        entry.bodyText = newBodyText
        
        //to persit the change on the api CALL THE PUT METHOD
        put(the: entry, completion: completion)
    }
    
    func put(the entry: Entry, completion: @escaping (Error?) -> Void){
        
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "PUT"
        
        do {
            let jE = JSONEncoder()
            
            //put the entry parameter into the body of the httpBody request
            requestURL.httpBody =  try jE.encode(entry)
            completion(nil)
        } catch  {
            print("Error putting data into the body of the http: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            if let error = error {
                print("Error in data task put function: \(error.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func fetchEntries(completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching Entry from the api: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do{
                let jD = JSONDecoder()
                let entryDictionary = try jD.decode([String : Entry].self, from: data)
                
                //turn the dictionary into an array
                let entryArray = Array(entryDictionary.values)
                
                //sort the array title < title
                let sortedEntries = entryArray.sorted(by: { $0.title < $1.title })
                self.entries = sortedEntries
                completion(nil)
                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(error)
                return
            }
        }
    }
    
}
