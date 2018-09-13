//
//  EntryController.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class EntryController {
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        
        //Looks good?
        putEntry(entry: entry, completion: completion)
    }
    
    func putEntry(entry: Entry, completion: @escaping (Error?) -> Void) {
        
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            NSLog("Error encoding entry: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTing entry: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not received from server")
                completion(NSError())
                return
            }
            
            let response = String(data: data, encoding: .utf8)!
            NSLog(response)
            
            self.entries.append(entry)
            completion(nil)
            
        }.resume()
    }
    
    // MARK: - Properties
    
    let baseURL = URL(string: "https://danielaparrajournal.firebaseio.com/")!
    
    var entries: [Entry] = []
}
