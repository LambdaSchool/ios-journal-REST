//
//  EntryController.swift
//  Journal
//
//  Created by Moin Uddin on 9/13/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


class EntryController {
    
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        var requestURL = baseURL.appendingPathComponent(entry.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        do {
            request.httpBody = try JSONEncoder().encode(entry)
        } catch {
            fatalError("Error encoding message \(entry): \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error posting new message: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            guard let index = self.entries.index(of: entry) else { return }
            self.entries[index] = entry
            print("PUT Successful")
            completion(nil)
        }.resume()

    }
    
    var baseURL = URL(string: "https://moinjournal.firebaseio.com/")!
    var entries: [Entry] = []
}
