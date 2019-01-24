//
//  EntryController.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class EntryController {
    
    var entries: [Entry] = []
    private let baseURL = URL(string: "https://console.firebase.google.com/project/journal-4f354/database/journal-4f354/data")!
    
    func put(an entry: Entry, completion: @escaping (Error?)-> Void) {
        
        let url = baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            //we have to encode the entry object into data. to send it to the server
            
        }
    }
}
